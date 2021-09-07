//
//  YTHomeDemoViewController.swift
//  YTCustomCollectionViewSwift
//
//  Created by YT on 2021/7/5.
//

import UIKit

class YTHomeDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        self.createUI()
        self.viewModel.viewDidLoadAction()
    }
    
    /// collectionView
    private lazy var contentCollectionView: YTCollectionViewSwift = {
        let collectionView = YTCollectionViewSwift(frame: .zero, collectionViewLayout: YTCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.yt_setViewModel(self.viewModel)
        return collectionView
    }()
    
    /// viewModel
    private lazy var viewModel: YTHomeDemoViewModel = {
        return YTHomeDemoViewModel()
    }()
}

extension YTHomeDemoViewController {
    
    private func createUI() {
        
        self.view.addSubview(self.contentCollectionView)
        self.layoutUI()
    }
    
    private func layoutUI() {
        
        self.contentCollectionView.frame = self.view.frame
    }
}
