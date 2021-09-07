//
//  EHICollectionViewModelProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/23.
//
//  viewModel协议(持有collectionview)

import UIKit

protocol EHICollectionViewModelProtocol {
    
    var ehi_CollectionView: (UICollectionView & EHICollectionViewProtocol)? {get set}
}

