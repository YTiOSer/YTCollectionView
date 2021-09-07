//
//  EHICollectionViewCellProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//
//  cell协议(传递数据)

import UIKit

protocol EHICollectionViewCellProtocol: EHICellReusableProtocol {
    
    /// 加载数据
    func ehi_cellWithData(itemModel: EHICollectionViewCellModelProtocol) -> Void
}

extension EHICollectionViewCellProtocol {
    
    func ehi_cellWithData(itemModel: EHICollectionViewCellModelProtocol) -> Void {}
}
