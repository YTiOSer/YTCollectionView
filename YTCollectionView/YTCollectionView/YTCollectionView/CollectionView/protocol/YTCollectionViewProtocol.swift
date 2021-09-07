//
//  YTCollectionViewProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/23.
//
//  CollectionView协议

import UIKit

typealias YTCollectionViewModelType = NSObject & YTCollectionViewModelProtocol
typealias YTCollectionSectionItemType = NSObject & YTCollectionViewSectionItemProtocol
typealias YTCollectionCellModelType = NSObject & YTCollectionViewCellModelProtocol
typealias YTCollectionCellType = UICollectionViewCell & YTCollectionViewCellProtocol

protocol YTCollectionViewProtocol {
    
    /// 完成闭包
    typealias CompletionClosure = () -> Void
    
    /// sectionItem
    func sectionItem(of section: Int) -> YTCollectionSectionItemType?
    
    /// 插入Section级别数据
    func insertSection(with data: YTSectionData,
                       changeSectionData: YTSectionData,
                       completion: CompletionClosure)
    
    /// 插入CellModel级别数据
    func insertCellModel(with data: YTCellModelData,
                         changeCellModelData: YTCellModelData,
                         completion: CompletionClosure)
    
    /// 删除Section级别数据
    func deleteSection(with data: YTSectionData,
                       changeSectionData: YTSectionData,
                       completion: CompletionClosure)
    
    /// 删除CellModel级别数据
    func deleteCellModel(with data: YTCellModelData,
                         changeCellModelData: YTCellModelData,
                         completion: CompletionClosure)
    
    /// 加载数据
    func reload(with data: YTSectionData,
                animation: Bool)
    
    /// 刷新某个Section
    func refreshSection(with section: YTCollectionSectionItemType,
                        animation: Bool)
    
    /// 刷新多个Sections（不使用reloadData，用于有输入框情况下刷新不失去焦点）
    func refreshSections(withperformBatchUpdate sections: [YTCollectionSectionItemType],
                         animation: Bool)
    
    /// 刷新Sections
    func refreshSections(with indexSet: IndexSet)
    
    /// 刷新cells
    func refreshCell(with cellItems: [YTCollectionCellModelType],
                     animation: Bool)
    
    /// 刷新IndexPathS
    func refreshCell(with indexPaths: [IndexPath],
                     animation: Bool)
    
    /// 返回指定indexPath在collectionView中的位置
    func collectionCellIndexPath(_ indexPath: IndexPath) -> CGRect
}

extension YTCollectionViewProtocol {
    
    /// sectionItem
    func sectionItem(of section: Int) -> YTCollectionSectionItemType? {
        return nil
    }
    
    /// 插入Section级别数据
    func insertSection(with data: YTSectionData,
                       changeSectionData: YTSectionData,
                       completion: CompletionClosure) {}
    
    /// 插入CellModel级别数据
    func insertCellModel(with data: YTCellModelData,
                         changeCellModelData: YTCellModelData,
                         completion: CompletionClosure) {}
    
    /// 删除Section级别数据
    func deleteSection(with data: YTSectionData,
                       changeSectionData: YTSectionData,
                       completion: CompletionClosure) {}
    
    /// 删除CellModel级别数据
    func deleteCellModel(with data: YTCellModelData,
                         changeCellModelData: YTCellModelData,
                         completion: CompletionClosure) {}
    
    /// 加载数据
    func reload(with data: YTSectionData,
                animation: Bool) {}
    
    /// 刷新Sections
    func refreshSection(with section: YTCollectionSectionItemType,
                        animation: Bool) {}
    
    /// 刷新Sections（不使用reloadData，用于有输入框情况下刷新不失去焦点）
    func refreshSections(withperformBatchUpdate sections: [YTCollectionSectionItemType],
                         animation: Bool) {}
    
    /// 刷新Sections
    func refreshSections(with indexSet: IndexSet) {}
    
    /// 刷新cells
    func refreshCell(with cellItems: [YTCollectionCellModelType],
                     animation: Bool) {}
    
    /// 刷新IndexPathS
    func refreshCell(with indexPaths: [IndexPath],
                     animation: Bool) {}
    
    /// 返回指定indexPath在collectionView中的位置
    func collectionCellIndexPath(_ indexPath: IndexPath) -> CGRect {
        return .zero
    }
}

