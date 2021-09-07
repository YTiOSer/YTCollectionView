//
//  EHICollectionViewProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/23.
//
//  CollectionView协议

import UIKit

typealias EHICollectionViewModelType = NSObject & EHICollectionViewModelProtocol
typealias EHICollectionSectionItemType = NSObject & EHICollectionViewSectionItemProtocol
typealias EHICollectionCellModelType = NSObject & EHICollectionViewCellModelProtocol
typealias EHICollectionCellType = UICollectionViewCell & EHICollectionViewCellProtocol

protocol EHICollectionViewProtocol {
    
    /// 完成闭包
    typealias CompletionClosure = () -> Void
    
    /// sectionItem
    func sectionItem(of section: Int) -> EHICollectionSectionItemType?
    
    /// 插入Section级别数据
    func insertSection(with data: EHISectionData,
                       changeSectionData: EHISectionData,
                       completion: CompletionClosure)
    
    /// 插入CellModel级别数据
    func insertCellModel(with data: EHICellModelData,
                         changeCellModelData: EHICellModelData,
                         completion: CompletionClosure)
    
    /// 删除Section级别数据
    func deleteSection(with data: EHISectionData,
                       changeSectionData: EHISectionData,
                       completion: CompletionClosure)
    
    /// 删除CellModel级别数据
    func deleteCellModel(with data: EHICellModelData,
                         changeCellModelData: EHICellModelData,
                         completion: CompletionClosure)
    
    /// 加载数据
    func reload(with data: EHISectionData,
                animation: Bool)
    
    /// 刷新某个Section
    func refreshSection(with section: EHICollectionSectionItemType,
                        animation: Bool)
    
    /// 刷新多个Sections（不使用reloadData，用于有输入框情况下刷新不失去焦点）
    func refreshSections(withperformBatchUpdate sections: [EHICollectionSectionItemType],
                         animation: Bool)
    
    /// 刷新Sections
    func refreshSections(with indexSet: IndexSet)
    
    /// 刷新cells
    func refreshCell(with cellItems: [EHICollectionCellModelType],
                     animation: Bool)
    
    /// 刷新IndexPathS
    func refreshCell(with indexPaths: [IndexPath],
                     animation: Bool)
    
    /// 返回指定indexPath在collectionView中的位置
    func collectionCellIndexPath(_ indexPath: IndexPath) -> CGRect
}

extension EHICollectionViewProtocol {
    
    /// sectionItem
    func sectionItem(of section: Int) -> EHICollectionSectionItemType? {
        return nil
    }
    
    /// 插入Section级别数据
    func insertSection(with data: EHISectionData,
                       changeSectionData: EHISectionData,
                       completion: CompletionClosure) {}
    
    /// 插入CellModel级别数据
    func insertCellModel(with data: EHICellModelData,
                         changeCellModelData: EHICellModelData,
                         completion: CompletionClosure) {}
    
    /// 删除Section级别数据
    func deleteSection(with data: EHISectionData,
                       changeSectionData: EHISectionData,
                       completion: CompletionClosure) {}
    
    /// 删除CellModel级别数据
    func deleteCellModel(with data: EHICellModelData,
                         changeCellModelData: EHICellModelData,
                         completion: CompletionClosure) {}
    
    /// 加载数据
    func reload(with data: EHISectionData,
                animation: Bool) {}
    
    /// 刷新Sections
    func refreshSection(with section: EHICollectionSectionItemType,
                        animation: Bool) {}
    
    /// 刷新Sections（不使用reloadData，用于有输入框情况下刷新不失去焦点）
    func refreshSections(withperformBatchUpdate sections: [EHICollectionSectionItemType],
                         animation: Bool) {}
    
    /// 刷新Sections
    func refreshSections(with indexSet: IndexSet) {}
    
    /// 刷新cells
    func refreshCell(with cellItems: [EHICollectionCellModelType],
                     animation: Bool) {}
    
    /// 刷新IndexPathS
    func refreshCell(with indexPaths: [IndexPath],
                     animation: Bool) {}
    
    /// 返回指定indexPath在collectionView中的位置
    func collectionCellIndexPath(_ indexPath: IndexPath) -> CGRect {
        return .zero
    }
}

