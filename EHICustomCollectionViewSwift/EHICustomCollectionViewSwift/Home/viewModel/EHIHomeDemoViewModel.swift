//
//  EHIHomeDemoViewModel.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/5.
//

import UIKit

class EHIHomeDemoViewModel: NSObject, EHICollectionViewModelProtocol {
    
    weak var ehi_CollectionView: (UICollectionView & EHICollectionViewProtocol)?
    
    /// item
    private lazy var items: EHISectionData = {
        return EHISectionData()
    }()
    
    /// sectionItem
    private lazy var sectionItem: EHIHomeDemoListSectionItem = {
        return EHIHomeDemoListSectionItem()
    }()
    
    /// 数据源
    private lazy var dataArray: [EHIHomeDemoListModel] = {
        return []
    }()
}

extension EHIHomeDemoViewModel {
    
    func viewDidLoadAction() {
        self.configData()
        self.configSectionItem()
    }
    
    func configData() {
        
        let count = 30
        
        for idx in 0..<count {
            let name = "张三-" + String(idx)
            let age = String(idx) + "岁"
            let model = EHIHomeDemoListModel(title: name, content: age)
            self.dataArray.append(model)
        }
    }
    
    func configSectionItem() {
        self.sectionItem.updateContent(self.dataArray)
        self.items.addObject(self.sectionItem)
        self.ehi_CollectionView?.reload(with: self.items, animation: true)
    }
}
