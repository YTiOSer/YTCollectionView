//
//  YTCollectionViewSectionItemProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/22.
//
//  sectionItem协议(UI和组装cell)

import UIKit

protocol YTCollectionViewSectionItemProtocol {
    
    /// section的内边距
    var yt_sectionInset: UIEdgeInsets {get set}
    
    /// section的列之间的 水平方向上间距
    var yt_horizontalSpacing: Int {get set}
    
    /// 同列之间间距 垂直方向上间距
    var yt_verticalSpacing: Int {get set}
    
    /// section
    var yt_section: Int {get set}
    
    /// section的BgColor
    var yt_sectionBgColor: UIColor {get set}
    
    /// section的BgColorInseets
    var yt_sectionBgColorInset: UIEdgeInsets {get set}
    
    /// cell集合
    var yt_cellItems: YTCellModelData? {get set}
    
    typealias callBackClosure = (_ indexPath: IndexPath, _ frame: CGRect) -> Void
    
    func prepareLayoutWith(collectionView: UICollectionView,
                           topSpace: CGFloat,
                           section: Int,
                           attributesClosure: callBackClosure,
                           decorationAttributeClosure: callBackClosure)
    
    func decorationView(layoutAttributes: YTCollectionViewLayoutAttributesSwift)
    
    mutating func setUp()
}

extension YTCollectionViewSectionItemProtocol {
    
    func prepareLayoutWith(collectionView: UICollectionView,
                           topSpace: CGFloat,
                           section: Int,
                           attributesClosure: callBackClosure,
                           decorationAttributeClosure: callBackClosure) {}
    
    func decorationView(layoutAttributes: YTCollectionViewLayoutAttributesSwift) {}
    
    func setUp() {}
}

