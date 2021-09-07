//
//  YTHomeDemoViewModel.swift
//  YTCustomCollectionViewSwift
//
//  Created by YT on 2021/7/5.
//

import UIKit

class YTHomeDemoViewModel: NSObject, YTCollectionViewModelProtocol {
    
    weak var yt_CollectionView: (UICollectionView & YTCollectionViewProtocol)?
    
    /// item
    private lazy var items: YTSectionData = {
        return YTSectionData()
    }()
    
    /// sectionItem
    private lazy var sectionItem: YTHomeDemoListSectionItem = {
        return YTHomeDemoListSectionItem()
    }()
    
    /// 数据源
    private lazy var dataArray: [YTHomeDemoListModel] = {
        return []
    }()
}

extension YTHomeDemoViewModel {
    
    func viewDidLoadAction() {
        self.configData()
        self.configSectionItem()
    }
    
    func configData() {
        
        let count = 30
        
        for idx in 0..<count {
            let name = "张三-" + String(idx)
            let age = String(idx) + "岁"
            let model = YTHomeDemoListModel(title: name, content: age)
            self.dataArray.append(model)
        }
    }
    
    func configSectionItem() {
        self.sectionItem.updateContent(self.dataArray)
        self.items.addObject(self.sectionItem)
        self.yt_CollectionView?.reload(with: self.items, animation: true)
    }
}
