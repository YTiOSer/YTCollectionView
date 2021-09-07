//
//  EHIHomeDemoViewController.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/5.
//

import UIKit

class EHIHomeDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        self.createUI()
        self.viewModel.viewDidLoadAction()
    }
    
    /// collectionView
    private lazy var contentCollectionView: EHICollectionViewSwift = {
        let collectionView = EHICollectionViewSwift(frame: .zero, collectionViewLayout: EHICollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.ehi_setViewModel(self.viewModel)
        return collectionView
    }()
    
    /// viewModel
    private lazy var viewModel: EHIHomeDemoViewModel = {
        return EHIHomeDemoViewModel()
    }()
}

extension EHIHomeDemoViewController {
    
    private func createUI() {
        
        self.view.addSubview(self.contentCollectionView)
        self.layoutUI()
    }
    
    private func layoutUI() {
        
        self.contentCollectionView.frame = self.view.frame
    }
}
