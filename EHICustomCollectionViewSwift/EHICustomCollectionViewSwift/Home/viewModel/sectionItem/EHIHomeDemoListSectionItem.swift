//
//  EHIHomeDemoListSectionItem.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/5.
//

import UIKit

class EHIHomeDemoListSectionItem: EHICollectionViewVerticalSectionItem {

    override init() {
        super.init()
        self.ehi_sectionInset = .init(top: 10, left: 16, bottom: 0, right: 16)
        self.ehi_horizontalSpacing = 0
        self.ehi_verticalSpacing = 0
        self.ehi_columnCount = 1
        self.ehi_sectionBgColor = .clear
    }
    
    func updateContent(_ array: [EHIHomeDemoListModel]) {
        
        self.ehi_cellItems?.removeAllObjects()
        
        array.forEach { [weak self] (mod) in
            guard let `self` = self else {return}
            let cellModel = EHIHomeDemoListCellModel(item: self, model: mod)
            self.ehi_cellItems?.array.append(cellModel)
        }
    }
}
