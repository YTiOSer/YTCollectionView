//
//  EHICollectionViewSwift.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/29.
//

import UIKit

class EHICollectionViewSwift: UICollectionView {

    typealias ScrollClosure = (UIScrollView) -> ()

    /// ViewModel
    var collectionViewModel: EHICollectionViewModelType?
    
    /// cell数据
    var cellClassArray: Array<AnyClass>?
    
    /// 滚动回调
    var scrollCallback: ScrollClosure?
    
    /// 开始滚动
    var scrollViewWillBeginDraggingBlock: ScrollClosure?
    
    /// 减速滚动
    var scrollViewDidEndDraggingBlock: ((_ scrollView : UIScrollView, _ decelerate :Bool) -> ())?
    
    /// 结束滚动
    var scrollViewDidEndDeceleratingBlock: ScrollClosure?
    
    /// 停止滚动
    var scrollViewDidEndScrollBlock: ScrollClosure?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.register(EHIEmptyCellSwift.self, forCellWithReuseIdentifier: EHIEmptyCellSwift.reuseableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// sectionItems数据源
    lazy var sectionItems: EHISectionData = {
        return EHISectionData(array: [])
    }()
    
    /// cell注册复用池子
    private lazy var cellReuseIdentifierSet: Set<String> = {
        return Set()
    }()
}

// MARK: 绑定viewModel
extension EHICollectionViewSwift {
    
    func ehi_setViewModel(_ viewModel: EHICollectionViewModelType) {
        self.collectionViewModel = viewModel
        self.collectionViewModel?.ehi_CollectionView = self
    }
}

// MARK: EHICollectionViewProtocol
extension EHICollectionViewSwift: EHICollectionViewProtocol {
    
    func reload(with data: EHISectionData, animation: Bool) {
        self.sectionItems = data
        self.reloadData()
    }
    
    func refreshSection(with section: EHICollectionSectionItemType, animation: Bool) {
        
        let indexSet = IndexSet(integer: section.ehi_section)
        
        if animation {
            self.performBatchUpdates {
                self.reloadSections(indexSet)
            } completion: { (_) in
                
            }
        } else {
            self.reloadSectionsMethod(indexSet: indexSet)
        }
    }
     
    func refreshSections(withperformBatchUpdate sections: [EHICollectionSectionItemType], animation: Bool) {
        var array = [IndexPath]()
        for item in sections {
            for object in (item.ehi_cellItems?.array ?? []) {
                if object.ehi_indexPath != IndexPath(index: 0) {
                    array.append(object.ehi_indexPath)
                }
            }
        }
        self.performBatchUpdates(nil, completion: nil)
    }
    
    func refreshSections(with indexSet: IndexSet) {
        self.reloadSectionsMethod(indexSet: indexSet)
    }
    
    func refreshCell(with indexPaths: [IndexPath], animation: Bool) {
        if indexPaths.count > 0 {
            self.performBatchUpdates {
                self.reloadCellMethod(indexPaths: indexPaths)
            } completion: { (_) in
                
            }
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.reloadCellMethod(indexPaths: indexPaths)
            CATransaction.commit()
        }
    }
    
    func refreshCell(with cellItems: [EHICollectionCellModelType], animation: Bool) {
        
        var indexPaths = [IndexPath]()
        for model in cellItems {
            indexPaths.append(model.ehi_indexPath)
        }
        
        if animation {
            self.performBatchUpdates {
                self.reloadCellMethod(indexPaths: indexPaths)
            } completion: { (_) in
                
            }
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.reloadCellMethod(indexPaths: indexPaths)
            CATransaction.commit()
        }
    }
    
    func collectionCellIndexPath(_ indexPath: IndexPath) -> CGRect {
        if let attr = self.layoutAttributesForItem(at: indexPath) {
            return attr.frame
        }
        return .zero
    }
    
    /// 通过indexset刷新sections
    private func reloadSectionsMethod(indexSet: IndexSet) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.reloadSections(indexSet)
        CATransaction.commit()
    }
    
    /// 通过indexset刷新cells
    private func reloadCellMethod(indexPaths: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.reloadItems(at: indexPaths)
        }
    }
    
    func sectionItem(of section: Int) -> EHICollectionSectionItemType? {
        if self.sectionItems.count > section {
            return self.sectionItems.array[section]
        }
        return nil
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension EHICollectionViewSwift: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionItem = self.sectionItems.array[section]
        return sectionItem.ehi_cellItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionItem = self.sectionItems.array[indexPath.section]
        let cellItem = sectionItem.ehi_cellItems?.array[indexPath.row]
        if let cellClassType = cellItem?.ehi_cellClass(){
            if let cellClass = cellClassType as? EHICollectionCellType.Type {
                var identifier = cellClass.reuseableIdentifier
                // 是否为xib
                var isNib = false
                if let nibName = cellItem?.ehi_cellNibName(), !nibName.isEmpty {
                    isNib = true
                    identifier = nibName
                }
                if !identifier.isEmpty {
                    if !self.cellReuseIdentifierSet.contains(identifier) {
                        // 注册cell
                        if isNib {
                            self.register(cellClass, forCellWithReuseIdentifier: identifier)
                        } else {
                            
                            self.register(cellClass, forCellWithReuseIdentifier: identifier)
                        }
                        self.cellReuseIdentifierSet.insert(identifier)
                    }

                    if let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? EHICollectionCellType {
                        cell.ehi_cellWithData(itemModel: cellItem!)
                        return cell
                    }
                }
            }
        }
        
        return self.dequeueReusableCell(withReuseIdentifier: EHIEmptyCellSwift.reuseableIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let items = self.sectionItems
        let sectionItem = items.object(at: indexPath.section)
        let cellModels = sectionItem.ehi_cellItems
        if let cellMod = cellModels?.object(at: indexPath.row), let closure = cellMod.ehi_didSelectActionClosure {
            closure(cellMod)
        }
    }
}

// MARK: 滚动
extension EHICollectionViewSwift {
    
    /// 开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewWillBeginDraggingBlock {
            closure(self)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let closure = self.scrollCallback {
            closure(self)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let closure = self.scrollViewDidEndDraggingBlock {
            closure(self, decelerate)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidEndDeceleratingBlock {
            closure(self)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidEndScrollBlock {
            closure(self)
        }
    }
}

extension UICollectionView {

    func registerCell<T>(_ cell: T.Type) where T: EHICollectionCellType {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reuseableIdentifier)
        } else {
            register(cell, forCellWithReuseIdentifier: T.reuseableIdentifier)
        }
    }

    func dequeReusableCell<T: EHICollectionCellType>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseableIdentifier, for: indexPath) as! T
    }
}
