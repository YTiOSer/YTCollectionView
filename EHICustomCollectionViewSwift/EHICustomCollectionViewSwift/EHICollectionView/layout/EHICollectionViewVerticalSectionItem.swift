//
//  EHICollectionViewVerticalSectionItem.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/2.
//

import UIKit

class EHICollectionViewVerticalSectionItem: NSObject, EHICollectionViewSectionItemProtocol {
    
    /// 协议属性
    var ehi_sectionInset: UIEdgeInsets = .zero
    
    var ehi_horizontalSpacing: Int = 0
    
    var ehi_verticalSpacing: Int = 0
    
    var ehi_section: Int = 0
    
    var ehi_sectionBgColor: UIColor = .white
    
    var ehi_sectionBgColorInset: UIEdgeInsets = .zero
    
    var ehi_cellItems: EHICellModelData?
    
    /// section的列数（一行cell个数）
    var ehi_columnCount: Int?
    
    /// 渐变色
    var ehi_gradientLayer: CAGradientLayer?
    
    /// 装饰视图-圆角
    var ehi_cornerRadius: CGFloat?
    
    /// 装饰视图
    var ehi_decorationView: UIView?
    
    /// 是否自动计算装饰view的大小
    var ehi_autoCalDecorationViewFrame: Bool?
    
    /// 背景视图大小刷新回调
    var ehi_decorateViewFrameRefresh: ((CGRect) -> Void)?
    
    var columnHeights: [CGFloat] = []
    
    override init() {
        super.init()
        self.setUp()
    }
    
    func setUp() {
        
        self.ehi_cellItems = EHICellModelData(section: self.ehi_section)
        self.ehi_gradientLayer = nil
        self.ehi_cornerRadius = 0
    }
}

extension EHICollectionViewVerticalSectionItem {
    
    func prepareLayoutWith(collectionView: UICollectionView, topSpace: CGFloat, section: Int, attributesClosure: (IndexPath, CGRect) -> Void, decorationAttributeClosure: (IndexPath, CGRect) -> Void) {
        
        
        self.columnHeights.removeAll()
        
        let columnCount = self.ehi_columnCount ?? 0
        for _ in 0..<columnCount {
            self.columnHeights.append(0)
        }
        
        var top: CGFloat = topSpace
        let lineSpacing = self.ehi_verticalSpacing
        let columnSpacing = self.ehi_horizontalSpacing
        let sectionInset = self.ehi_sectionInset
        
        top += sectionInset.top
        for _ in 0..<columnCount {
            self.columnHeights.append(top)
        }
        
        let width: Int = Int(floor(collectionView.bounds.size.width - sectionInset.left - sectionInset.right))
        var itemWidth = floor(Double((width - (columnCount - 1) * columnSpacing) / columnCount))
        let itemCount = self.ehi_cellItems?.count ?? 0
        var firstSize: CGRect = .zero
        var lastSize: CGRect = .zero
        
        for idx in 0..<itemCount {
            
            let indexPath = IndexPath(item: idx, section: section)
            var item = self.ehi_cellItems?.object(at: idx)
            item?.ehi_indexPath = indexPath
            let columnIndex = self.nextColumnIndex(for: idx)
            let xOffset: CGFloat = sectionInset.left + CGFloat((Int(itemWidth) + columnSpacing) * columnIndex)
            let yOffset: CGFloat = self.columnHeights[columnIndex]
            let itemSize = item?.ehi_cellSize
            let itemHeight = itemSize?.height ?? 0
            itemWidth = Double(itemSize?.width ?? 0)
            let frame = CGRect(x: xOffset, y: yOffset, width: CGFloat(itemWidth), height: itemHeight)
           
            attributesClosure(indexPath, frame)
            
            self.columnHeights[columnIndex] = frame.maxY + CGFloat(lineSpacing)
            
            if idx == 0 {
                firstSize = frame
            }
            if idx == itemCount - 1 {
                lastSize = frame
            }
        }
        
        let columnIndex = self.longestColumnIndex(in: section)
        
        if self.columnHeights.count > 0 {
            top = self.columnHeights[columnIndex] - CGFloat(lineSpacing) + sectionInset.bottom
        } else {
            top = 0
        }
        
        for idx in 0..<columnCount {
            self.columnHeights[idx] = top
        }
        
        var sectionFrame: CGRect = firstSize.union(lastSize)
        sectionFrame.origin.x -= self.ehi_sectionInset.left
        sectionFrame.origin.y -= self.ehi_sectionInset.top
        sectionFrame.size.width = collectionView.frame.size.width
        sectionFrame.size.height += self.ehi_sectionInset.top + self.ehi_sectionInset.bottom
        
        if self.ehi_sectionBgColorInset != .zero {
            sectionFrame.origin.x = sectionFrame.origin.x + self.ehi_sectionBgColorInset.left
            sectionFrame.origin.y = sectionFrame.origin.y + self.ehi_sectionBgColorInset.top
            sectionFrame.size.width = sectionFrame.size.width - self.ehi_sectionBgColorInset.left - self.ehi_sectionBgColorInset.right
            sectionFrame.size.height = sectionFrame.size.height - self.ehi_sectionBgColorInset.top - self.ehi_sectionBgColorInset.bottom
        }
        
        let indexPath = IndexPath(item: 0, section: section)
        decorationAttributeClosure(indexPath, sectionFrame)
        
        if let closure = self.ehi_decorateViewFrameRefresh {
            closure(sectionFrame)
        }
    }
    
    func decorationView(layoutAttributes: EHICollectionViewLayoutAttributesSwift) {
        layoutAttributes.sectionBgColor = self.ehi_sectionBgColor
        layoutAttributes.gradientLayer = self.ehi_gradientLayer
        layoutAttributes.ehi_cornerRadius = self.ehi_cornerRadius
        layoutAttributes.decorationView = self.ehi_decorationView
        layoutAttributes.autoCalDecorationViewFrame = self.ehi_autoCalDecorationViewFrame
    }
}

extension EHICollectionViewVerticalSectionItem {
    
    /// 返回下一列的索引
    private func nextColumnIndex(for item: Int) -> Int {
        var index = 0
        let columnCount = self.ehi_columnCount ?? 0
        index = item % columnCount
        return index
    }
    
    /// 查找section中item的height最大的index
    private func longestColumnIndex(in section: Int) -> Int {
        var index = 0
        var longestHeight: CGFloat = 0
        for (idx, obj) in self.columnHeights.enumerated() {
            if obj > longestHeight {
                longestHeight = obj
                index = idx
            }
        }
        return index
    }
}

extension EHICollectionViewVerticalSectionItem {
    
    func calculateCellWidth(totalWidth:CGFloat) -> CGFloat {
        
        let horizonWidth = self.ehi_horizontalSpacing * (self.ehi_columnCount ?? 0 - 1)
        let contentWidth = totalWidth - self.ehi_sectionInset.left - self.ehi_sectionInset.right - CGFloat(horizonWidth)
        let cellWidth = contentWidth / CGFloat(self.ehi_columnCount ?? 0)
        return cellWidth
    }
}

extension EHICollectionViewVerticalSectionItem: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let item = EHICollectionViewVerticalSectionItem()
        item.ehi_columnCount = self.ehi_columnCount
        item.ehi_sectionInset = self.ehi_sectionInset
        item.ehi_horizontalSpacing = self.ehi_horizontalSpacing
        item.ehi_verticalSpacing = self.ehi_verticalSpacing
        item.ehi_sectionBgColor = self.ehi_sectionBgColor
        item.ehi_sectionBgColorInset = self.ehi_sectionBgColorInset
        item.ehi_section = self.ehi_section
        item.ehi_gradientLayer = self.ehi_gradientLayer
        item.ehi_cornerRadius = self.ehi_cornerRadius
        if let cellMods = self.ehi_cellItems?.copy() as? EHICellModelData {
            item.ehi_cellItems = cellMods
        }
        return item
    }
}
