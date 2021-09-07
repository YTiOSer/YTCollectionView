//
//  YTCollectionViewCellModelProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/22.
//
//  cellModel协议(UI、布局、回调)

import UIKit

protocol YTCollectionViewCellModelProtocol {
    
    /// 需要自己计算的cellSize
    var yt_cellSize: CGSize {get set}
    
    /// 在YTCollectionViewLayout计算得到
    var yt_indexPath: IndexPath {get set}
    
    /// 刷新cell的回调
    var yt_refreshCellClosure: ((YTCollectionViewCellModelProtocol) -> Void)? {get}
    
    /// 点击cell的回调
    var yt_didSelectActionClosure: ((YTCollectionViewCellModelProtocol) -> Void)? {get}
    
    /// 对应cell的类
    func yt_cellClass() -> AnyClass
    
    /// 对应nib的名字
    func yt_cellNibName() -> String
    
    func yt_setCorners(_ corners: UIRectCorner, radius: Int)
}

extension YTCollectionViewCellModelProtocol {
    
    var yt_cellSize: CGSize {
        get {
            return .zero
        }
        set {
            self.yt_cellSize = newValue
        }
    }
    
    var yt_indexPath: IndexPath {
        get {
            return IndexPath(index: 0)
        }
        set {
//            self.ehi_indexPath = newValue
        }
    }
    
    var yt_refreshCellClosure: ((YTCollectionViewCellModelProtocol) -> Void)? {
        get {
            return nil
        }
    }
    
    var yt_didSelectActionClosure: ((YTCollectionViewCellModelProtocol) -> Void)? {
        get {
            return nil
        }
    }
}

extension YTCollectionViewCellModelProtocol {
    
    func ehi_cellClass() -> AnyClass {
        assert(false, "子类必须实现该方法，且不可调用父类方法")
        return YTEmptyCellSwift.self
    }
    
    /// 对应nib的名字
    func yt_cellNibName() -> String {
        return ""
    }
    
    func yt_setCorners(_ corners: UIRectCorner, radius: Int) {}
}
