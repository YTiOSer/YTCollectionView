//
//  YTCollectionViewModelProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/23.
//
//  viewModel协议(持有collectionview)

import UIKit

protocol YTCollectionViewModelProtocol {
    
    var yt_CollectionView: (UICollectionView & YTCollectionViewProtocol)? {get set}
}

