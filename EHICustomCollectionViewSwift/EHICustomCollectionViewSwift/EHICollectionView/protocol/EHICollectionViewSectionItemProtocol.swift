//
//  EHICollectionViewSectionItemProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//
//  sectionItem协议(UI和组装cell)

import UIKit

protocol EHICollectionViewSectionItemProtocol {
    
    /// section的内边距
    var ehi_sectionInset: UIEdgeInsets {get set}
    
    /// section的列之间的 水平方向上间距
    var ehi_horizontalSpacing: Int {get set}
    
    /// 同列之间间距 垂直方向上间距
    var ehi_verticalSpacing: Int {get set}
    
    /// section
    var ehi_section: Int {get set}
    
    /// section的BgColor
    var ehi_sectionBgColor: UIColor {get set}
    
    /// section的BgColorInseets
    var ehi_sectionBgColorInset: UIEdgeInsets {get set}
    
    /// cell集合
    var ehi_cellItems: EHICellModelData? {get set}
    
    typealias callBackClosure = (_ indexPath: IndexPath, _ frame: CGRect) -> Void
    
    func prepareLayoutWith(collectionView: UICollectionView,
                           topSpace: CGFloat,
                           section: Int,
                           attributesClosure: callBackClosure,
                           decorationAttributeClosure: callBackClosure)
    
    func decorationView(layoutAttributes: EHICollectionViewLayoutAttributesSwift)
    
    mutating func setUp()
}

//extension EHICollectionViewSectionItemProtocol {
//
//    var ehi_sectionInset: UIEdgeInsets {
//        get {
//            return .zero
//        }
//        set {
//            self.ehi_sectionInset = newValue
//        }
//    }
//
//    var ehi_horizontalSpacing: Int {
//        get {
//            return 0
//        }
//        set {
//            self.ehi_horizontalSpacing = newValue
//        }
//    }
//
//    var ehi_verticalSpacing: Int {
//        get {
//            return 0
//        }
//        set {
//            self.ehi_verticalSpacing = newValue
//        }
//    }
//
//    var ehi_section: Int {
//        get {
//            return 0
//        }
//        set {
//            self.ehi_section = newValue
//        }
//    }
//
//    var ehi_sectionBgColor: UIColor {
//        get {
//            return .clear
//        }
//        set {
//            self.ehi_sectionBgColor = newValue
//        }
//    }
//
//    var ehi_sectionBgColorInset: UIEdgeInsets {
//        get {
//            return .zero
//        }
//        set {
//            self.ehi_sectionBgColorInset = newValue
//        }
//    }
//
//    var ehi_cellItems: EHICellModelData? {
//        get {
//            return nil
//        }
//        set {
//            self.ehi_cellItems = newValue
//        }
//    }
//}

extension EHICollectionViewSectionItemProtocol {
    
    func prepareLayoutWith(collectionView: UICollectionView,
                           topSpace: CGFloat,
                           section: Int,
                           attributesClosure: callBackClosure,
                           decorationAttributeClosure: callBackClosure) {}
    
    func decorationView(layoutAttributes: EHICollectionViewLayoutAttributesSwift) {}
    
    func setUp() {}
}

