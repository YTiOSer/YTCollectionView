//
//  YTEmptyCellModelSwift.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/28.
//

import UIKit

class YTEmptyCellModelSwift: NSObject, YTCollectionViewCellModelProtocol {
    
    func yt_cellClass() -> AnyClass {
        return YTEmptyCellSwift.self
    }
}
