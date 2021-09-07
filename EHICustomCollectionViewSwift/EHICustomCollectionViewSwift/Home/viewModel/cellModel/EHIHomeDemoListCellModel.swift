//
//  EHIHomeDemoListCellModel.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/5.
//

import UIKit

class EHIHomeDemoListCellModel: NSObject, EHICollectionViewCellModelProtocol {

    var ehi_cellSize: CGSize = .zero
    
    var model: EHIHomeDemoListModel?
    
    init(item: EHICollectionViewVerticalSectionItem, model: EHIHomeDemoListModel) {
        super.init()
        
        let screenWidth = UIScreen.main.bounds.size.width
        self.ehi_cellSize = .init(width: item.calculateCellWidth(totalWidth: screenWidth), height: 70)
        self.model = model
    }
}

extension EHIHomeDemoListCellModel {
    
    func ehi_cellClass() -> AnyClass {
        return EHIHomeDemoListCell.self
    }
}
