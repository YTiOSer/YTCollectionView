//
//  YTHomeDemoListSectionItem.swift
//  YTCustomCollectionViewSwift
//
//  Created by YT on 2021/7/5.
//

import UIKit

class YTHomeDemoListSectionItem: YTCollectionViewVerticalSectionItem {

    override init() {
        super.init()
        self.yt_sectionInset = .init(top: 10, left: 16, bottom: 0, right: 16)
        self.yt_horizontalSpacing = 0
        self.yt_verticalSpacing = 0
        self.yt_columnCount = 1
        self.yt_sectionBgColor = .clear
    }
    
    func updateContent(_ array: [YTHomeDemoListModel]) {
        
        self.yt_cellItems?.removeAllObjects()
        
        array.forEach { [weak self] (mod) in
            guard let `self` = self else {return}
            let cellModel = YTHomeDemoListCellModel(item: self, model: mod)
            self.yt_cellItems?.array.append(cellModel)
        }
    }
}
