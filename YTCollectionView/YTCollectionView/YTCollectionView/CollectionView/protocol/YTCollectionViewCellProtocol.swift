//
//  YTCollectionViewCellProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/22.
//
//  cell协议(传递数据)

import UIKit

protocol YTCollectionViewCellProtocol: YTCellReusableProtocol {
    
    /// 加载数据
    func yt_cellWithData(itemModel: YTCollectionViewCellModelProtocol) -> Void
}

extension YTCollectionViewCellProtocol {
    
    func yt_cellWithData(itemModel: YTCollectionViewCellModelProtocol) -> Void {}
}
