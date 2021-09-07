//
//  YTCollectionViewVerticalSectionItem.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/7/2.
//

import UIKit

class YTCollectionViewVerticalSectionItem: NSObject, YTCollectionViewSectionItemProtocol {
    
    /// 协议属性
    var yt_sectionInset: UIEdgeInsets = .zero
    
    var yt_horizontalSpacing: Int = 0
    
    var yt_verticalSpacing: Int = 0
    
    var yt_section: Int = 0
    
    var yt_sectionBgColor: UIColor = .white
    
    var yt_sectionBgColorInset: UIEdgeInsets = .zero
    
    var yt_cellItems: YTCellModelData?
    
    /// section的列数（一行cell个数）
    var yt_columnCount: Int?
    
    /// 渐变色
    var yt_gradientLayer: CAGradientLayer?
    
    /// 装饰视图-圆角
    var yt_cornerRadius: CGFloat?
    
    /// 装饰视图
    var yt_decorationView: UIView?
    
    /// 是否自动计算装饰view的大小
    var yt_autoCalDecorationViewFrame: Bool?
    
    /// 背景视图大小刷新回调
    var yt_decorateViewFrameRefresh: ((CGRect) -> Void)?
    
    var columnHeights: [CGFloat] = []
    
    override init() {
        super.init()
        self.setUp()
    }
    
    func setUp() {
        
        self.yt_cellItems = YTCellModelData(section: self.yt_section)
        self.yt_gradientLayer = nil
        self.yt_cornerRadius = 0
    }
}

extension YTCollectionViewVerticalSectionItem {
    
    func prepareLayoutWith(collectionView: UICollectionView, topSpace: CGFloat, section: Int, attributesClosure: (IndexPath, CGRect) -> Void, decorationAttributeClosure: (IndexPath, CGRect) -> Void) {
        
        
        self.columnHeights.removeAll()
        
        let columnCount = self.yt_columnCount ?? 0
        for _ in 0..<columnCount {
            self.columnHeights.append(0)
        }
        
        var top: CGFloat = topSpace
        let lineSpacing = self.yt_verticalSpacing
        let columnSpacing = self.yt_horizontalSpacing
        let sectionInset = self.yt_sectionInset
        
        top += sectionInset.top
        for _ in 0..<columnCount {
            self.columnHeights.append(top)
        }
        
        let width: Int = Int(floor(collectionView.bounds.size.width - sectionInset.left - sectionInset.right))
        var itemWidth = floor(Double((width - (columnCount - 1) * columnSpacing) / columnCount))
        let itemCount = self.yt_cellItems?.count ?? 0
        var firstSize: CGRect = .zero
        var lastSize: CGRect = .zero
        
        for idx in 0..<itemCount {
            
            let indexPath = IndexPath(item: idx, section: section)
            var item = self.yt_cellItems?.object(at: idx)
            item?.yt_indexPath = indexPath
            let columnIndex = self.nextColumnIndex(for: idx)
            let xOffset: CGFloat = sectionInset.left + CGFloat((Int(itemWidth) + columnSpacing) * columnIndex)
            let yOffset: CGFloat = self.columnHeights[columnIndex]
            let itemSize = item?.yt_cellSize
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
        sectionFrame.origin.x -= self.yt_sectionInset.left
        sectionFrame.origin.y -= self.yt_sectionInset.top
        sectionFrame.size.width = collectionView.frame.size.width
        sectionFrame.size.height += self.yt_sectionInset.top + self.yt_sectionInset.bottom
        
        if self.yt_sectionBgColorInset != .zero {
            sectionFrame.origin.x = sectionFrame.origin.x + self.yt_sectionBgColorInset.left
            sectionFrame.origin.y = sectionFrame.origin.y + self.yt_sectionBgColorInset.top
            sectionFrame.size.width = sectionFrame.size.width - self.yt_sectionBgColorInset.left - self.yt_sectionBgColorInset.right
            sectionFrame.size.height = sectionFrame.size.height - self.yt_sectionBgColorInset.top - self.yt_sectionBgColorInset.bottom
        }
        
        let indexPath = IndexPath(item: 0, section: section)
        decorationAttributeClosure(indexPath, sectionFrame)
        
        if let closure = self.yt_decorateViewFrameRefresh {
            closure(sectionFrame)
        }
    }
    
    func decorationView(layoutAttributes: YTCollectionViewLayoutAttributesSwift) {
        layoutAttributes.sectionBgColor = self.yt_sectionBgColor
        layoutAttributes.gradientLayer = self.yt_gradientLayer
        layoutAttributes.yt_cornerRadius = self.yt_cornerRadius
        layoutAttributes.decorationView = self.yt_decorationView
        layoutAttributes.autoCalDecorationViewFrame = self.yt_autoCalDecorationViewFrame
    }
}

extension YTCollectionViewVerticalSectionItem {
    
    /// 返回下一列的索引
    private func nextColumnIndex(for item: Int) -> Int {
        var index = 0
        let columnCount = self.yt_columnCount ?? 0
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

extension YTCollectionViewVerticalSectionItem {
    
    func calculateCellWidth(totalWidth:CGFloat) -> CGFloat {
        
        let horizonWidth = self.yt_horizontalSpacing * (self.yt_columnCount ?? 0 - 1)
        let contentWidth = totalWidth - self.yt_sectionInset.left - self.yt_sectionInset.right - CGFloat(horizonWidth)
        let cellWidth = contentWidth / CGFloat(self.yt_columnCount ?? 0)
        return cellWidth
    }
}

extension YTCollectionViewVerticalSectionItem: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let item = YTCollectionViewVerticalSectionItem()
        item.yt_columnCount = self.yt_columnCount
        item.yt_sectionInset = self.yt_sectionInset
        item.yt_horizontalSpacing = self.yt_horizontalSpacing
        item.yt_verticalSpacing = self.yt_verticalSpacing
        item.yt_sectionBgColor = self.yt_sectionBgColor
        item.yt_sectionBgColorInset = self.yt_sectionBgColorInset
        item.yt_section = self.yt_section
        item.yt_gradientLayer = self.yt_gradientLayer
        item.yt_cornerRadius = self.yt_cornerRadius
        if let cellMods = self.yt_cellItems?.copy() as? YTCellModelData {
            item.yt_cellItems = cellMods
        }
        return item
    }
}
