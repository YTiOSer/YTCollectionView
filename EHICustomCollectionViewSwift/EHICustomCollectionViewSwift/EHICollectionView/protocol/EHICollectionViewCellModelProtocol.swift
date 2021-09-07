//
//  EHICollectionViewCellModelProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//
//  cellModel协议(UI、布局、回调)

import UIKit

protocol EHICollectionViewCellModelProtocol {
    
    /// 需要自己计算的cellSize
    var ehi_cellSize: CGSize {get set}
    
    /// 在SEEDCollectionViewLayout计算得到
    var ehi_indexPath: IndexPath {get set}
    
    /// 刷新cell的回调
    var ehi_refreshCellClosure: ((EHICollectionViewCellModelProtocol) -> Void)? {get}
    
    /// 点击cell的回调
    var ehi_didSelectActionClosure: ((EHICollectionViewCellModelProtocol) -> Void)? {get}
    
    /// 对应cell的类
    func ehi_cellClass() -> AnyClass
    
    /// 对应nib的名字
    func ehi_cellNibName() -> String
    
    func ehi_setCorners(_ corners: UIRectCorner, radius: Int)
}

extension EHICollectionViewCellModelProtocol {
    
    var ehi_cellSize: CGSize {
        get {
            return .zero
        }
        set {
            self.ehi_cellSize = newValue
        }
    }
    
    var ehi_indexPath: IndexPath {
        get {
            return IndexPath(index: 0)
        }
        set {
//            self.ehi_indexPath = newValue
        }
    }
    
    var ehi_refreshCellClosure: ((EHICollectionViewCellModelProtocol) -> Void)? {
        get {
            return nil
        }
    }
    
    var ehi_didSelectActionClosure: ((EHICollectionViewCellModelProtocol) -> Void)? {
        get {
            return nil
        }
    }
}

extension EHICollectionViewCellModelProtocol {
    
    func ehi_cellClass() -> AnyClass {
        assert(false, "子类必须实现该方法，且不可调用父类方法")
        return EHIEmptyCellSwift.self
    }
    
    /// 对应nib的名字
    func ehi_cellNibName() -> String {
        return ""
    }
    
    func ehi_setCorners(_ corners: UIRectCorner, radius: Int) {}
}
