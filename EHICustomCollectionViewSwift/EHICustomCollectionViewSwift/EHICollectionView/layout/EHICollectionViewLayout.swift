//
//  EHICollectionViewLayout.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/1.
//

import UIKit

class EHICollectionViewLayout: UICollectionViewLayout {
    
    /// 列的高度数组
    lazy var columnHeightArray: Array = {
        return []
    }()
    
    /// 二维数组 section对应item的布局有关的属性的数组
    lazy var sectionItemAttributesArray: [[UICollectionViewLayoutAttributes]] = {
        return [[UICollectionViewLayoutAttributes]]()
    }()
    
    /// section的布局有关的属性的数组(装饰)
    var sectionAttributes: [UICollectionViewLayoutAttributes] = {
        return []
    }()
    
    /// section的布局有关的属性的数组(insert)
    var addAttributesIndexPathArray: [IndexPath] = {
        return []
    }()
    
    /// 需要刷新的时候indexPath
    var reloadIndexPathArray: [IndexPath] = {
        return []
    }()
    
    /// 需要刷新的时候indexPath(delete)
    var deletIndexPathArray: [IndexPath] = {
        return []
    }()
    
    /// item的布局有关的属性的数组
    var allItemAttributes: [UICollectionViewLayoutAttributes] = {
        return []
    }()
    
    /// Sections数组
    var sectionItems: [EHICollectionSectionItemType] = {
        return []
    }()
}

// MARK: 重载父类方法
extension EHICollectionViewLayout {
    
    /// 设置layout的结果和初试需要的参数等
    override func prepare() {
        super.prepare()
        
        self.register(EHICollectionReusableViewSwift.self, forDecorationViewOfKind: EHICollectionReusableViewSwift.reuseableIdentifier)
        
        self.columnHeightArray.removeAll()
        self.allItemAttributes.removeAll()
        self.sectionItemAttributesArray.removeAll()
        self.sectionAttributes.removeAll()
        
        guard let ehiCollectionView = self.collectionView as? EHICollectionViewSwift, ehiCollectionView.sectionItems.count > 0 else {return}
        
        let items = ehiCollectionView.sectionItems
        
        for section in 0..<items.count {
            
            let sectionItem: EHICollectionSectionItemType = items.array[section]
            var itemAttributes: [UICollectionViewLayoutAttributes] = []
            
            var maxHeight: CGFloat = 0
            if section == 0 {
                maxHeight = 0
            } else {
                maxHeight = self.maxHeight(with: self.sectionItemAttributesArray[section - 1], sectionItem: items.array[section - 1])
            }
            
            sectionItem.prepareLayoutWith(collectionView: self.collectionView!, topSpace: maxHeight, section: section, attributesClosure: { [weak self] (indexPath, frame) in
                guard let `self` = self else { return }
                let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                attributes.frame = frame
                itemAttributes.append(attributes)
                self.allItemAttributes.append(attributes)
            }, decorationAttributeClosure: { [weak self] (indexPath, frame) in
                guard let `self` = self else { return }
                let decorationAttributes = EHICollectionViewLayoutAttributesSwift(forDecorationViewOfKind: EHICollectionReusableViewSwift.reuseableIdentifier, with: IndexPath(row: 0, section: indexPath.section))
                decorationAttributes.frame = frame
                decorationAttributes.zIndex = -1
                decorationAttributes.sectionBgColor = sectionItem.ehi_sectionBgColor
                sectionItem.decorationView(layoutAttributes:decorationAttributes)
                self.sectionAttributes.append(decorationAttributes)
            })
            self.sectionItemAttributesArray.append(itemAttributes)
        }
    }
    
    /// 返回collectionView的内容的尺寸
    override var collectionViewContentSize: CGSize {
        get {
            let numberOfSections = self.collectionView?.numberOfSections
            if numberOfSections == 0 {
                return .zero
            }
            
            var contentSize = self.collectionView?.bounds.size
            let maxHeight = self.maxHeight(with: self.allItemAttributes, sectionItem: nil)
            if maxHeight > 0 {
                contentSize?.height = maxHeight
            }
            
            return contentSize ?? .zero
        }
    }
    
    /**
     UICollectionView调用下面这四个方法来确定布局信息。
     实现-layoutAttributesForElementsInRect:为补充或装饰视图返回布局属性，或在屏幕上按需要的方式执行布局。
     此外，所有布局的子类应该实现-layoutAttributesForItemAtIndexPath:返回布局属性实例的特定索引路径。
     如果布局支持任何补充或装饰视图类型，它也应该为这些类型实现相应的atIndexPath:方法。
     UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
     1)layoutAttributesForCellWithIndexPath:
     2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
     3)layoutAttributesForDecorationViewOfKind:withIndexPath:
     */
    
    /**
     返回rect中的所有的元素的布局属性
     rect: CGRect
     return: 包含UICollectionViewLayoutAttributes的NSArray
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.allItemAttributes.append(contentsOf: self.sectionAttributes)
        return self.allItemAttributes
    }
    
    /**
     返回对应于indexPath的位置的cell的布局属性(从sectionItemAttributesArray取)
     indexPath: 对应的Indexpath
     return: 布局属性
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.section >= self.sectionItemAttributesArray.count {
            return nil
        }
        if indexPath.item >= self.sectionItemAttributesArray[indexPath.section].count {
            return nil
        }
        return self.sectionItemAttributesArray[indexPath.section][indexPath.row]
    }
    
    /// 返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }
    
    /// 返回对应于indexPath的位置的装饰视图的布局属性
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == EHICollectionReusableViewSwift.reuseableIdentifier {
            return self.sectionAttributes[indexPath.section]
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
    
    /// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /// cell要更新的布局
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
    }
    
    /// 追加视图插入的布局信息
    override func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.initialLayoutAttributesForAppearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
    }
    
    /// 装饰视图插入的布局信息
    override func initialLayoutAttributesForAppearingDecorationElement(ofKind elementKind: String, at decorationIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.initialLayoutAttributesForAppearingDecorationElement(ofKind: elementKind, at: decorationIndexPath)
    }
    
    /// cell移除时候的布局信息
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        for sectionPath in self.reloadIndexPathArray {
            if sectionPath.section == itemIndexPath.section {
                /// 自定义
            }
        }
        return attributes
    }
    
    /// 追加视图移除的布局信息
    override func finalLayoutAttributesForDisappearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.finalLayoutAttributesForDisappearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
    }
    
    /// 装饰视图移除的布局信息
    override func finalLayoutAttributesForDisappearingDecorationElement(ofKind elementKind: String, at decorationIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.finalLayoutAttributesForDisappearingDecorationElement(ofKind: elementKind, at: decorationIndexPath)
    }
    
    /**
     当对集合视图进行带有删除/插入操作的更新时，调用此方法。
     它将在调用下面的初始/最终布局属性方法之前被调用，以使布局有机会对插入和删除布局属性进行批处理计算。
     updateItems参数是一个UICollectionViewUpdateItem实例数组，用于移动到一个新的索引路径的每个元。
     */
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
       
        self.deletIndexPathArray = []
        self.addAttributesIndexPathArray = []
        self.reloadIndexPathArray = []
        
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for updateItem in updateItems {
            switch updateItem.updateAction {
            case .reload:
                self.reloadIndexPathArray.append(updateItem.indexPathAfterUpdate ?? IndexPath())
            case .insert:
                self.addAttributesIndexPathArray.append(updateItem.indexPathAfterUpdate ?? IndexPath())
            case .delete:
                self.deletIndexPathArray.append(updateItem.indexPathAfterUpdate ?? IndexPath())
            case .move:
                break
            default:
                break
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        self.reloadIndexPathArray.removeAll()
        self.deletIndexPathArray.removeAll()
        self.addAttributesIndexPathArray.removeAll()
    }
}

// MARK: 私有方法
extension EHICollectionViewLayout {
    
    private func maxHeight(with attributesArray: [UICollectionViewLayoutAttributes], sectionItem: EHICollectionSectionItemType?) -> CGFloat {
        var longestHeight: CGFloat = 0
        attributesArray.forEach { (attributes) in
            if attributes.frame.maxY > longestHeight {
                longestHeight = attributes.frame.maxY
            }
        }
        
        if let item = sectionItem {
            longestHeight = longestHeight + item.ehi_sectionInset.bottom
        }
        return longestHeight
    }
}
