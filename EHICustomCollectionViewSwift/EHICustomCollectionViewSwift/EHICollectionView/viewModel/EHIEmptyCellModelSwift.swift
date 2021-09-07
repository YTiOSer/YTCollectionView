//
//  EHIEmptyCellModelSwift.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/28.
//

import UIKit

class EHIEmptyCellModelSwift: NSObject, EHICollectionViewCellModelProtocol {
    
    func ehi_cellClass() -> AnyClass {
        return EHIEmptyCellSwift.self
    }
}
