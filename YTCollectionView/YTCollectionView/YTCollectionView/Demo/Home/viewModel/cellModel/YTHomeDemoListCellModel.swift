//
//  YTHomeDemoListCellModel.swift
//  YTCustomCollectionViewSwift
//
//  Created by YT on 2021/7/5.
//

import UIKit

class YTHomeDemoListCellModel: NSObject, YTCollectionViewCellModelProtocol {

    var yt_cellSize: CGSize = .zero
    
    var model: YTHomeDemoListModel?
    
    init(item: YTCollectionViewVerticalSectionItem, model: YTHomeDemoListModel) {
        super.init()
        
        let screenWidth = UIScreen.main.bounds.size.width
        self.yt_cellSize = .init(width: item.calculateCellWidth(totalWidth: screenWidth), height: 70)
        self.model = model
    }
}

extension YTHomeDemoListCellModel {
    
    func yt_cellClass() -> AnyClass {
        return YTHomeDemoListCell.self
    }
}
