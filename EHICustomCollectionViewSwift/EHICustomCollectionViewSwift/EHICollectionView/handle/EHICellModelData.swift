//
//  EHICellModelData.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//

import UIKit

class EHICellModelData: NSObject {
    
    /// 初始化
    override init() {
        super.init()
    }
    
    /// 便利构造
    convenience init(section: Int) {
        self.init()
        self.section = section
    }
    
    /// 信号量
    lazy var semaphore: DispatchSemaphore = {
        return DispatchSemaphore.init(value: 1)
    }()
    
    /// 数组
    lazy var array: Array<EHICollectionCellModelType> = {
        return []
    }()
    
    /// section
    lazy private(set) var section: Int = {
        return 0
    }()
}

extension EHICellModelData: EHICollectionViewDataProtocol {
    
    func sortIndex() -> Void {
        
        for i in 0..<self.array.count {
            var cellModel = self.array[i]
            cellModel.ehi_indexPath = IndexPath.init(row: i, section: self.section)
        }
    }
    
    /// remove
    func removeObject(at index: Int) {
        self.semaphore.wait()
        self.array.remove(at: index)
        self.sortIndex()
        self.semaphore.signal()
    }
    
    func removeObject(_ object: EHICollectionCellModelType) {
        self.semaphore.wait()
        for i in 0..<self.array.count {
            let cellModel = self.array[i]
            if (cellModel.isEqual(object)) {
                self.array.remove(at: i)
                break
            }
        }
        self.semaphore.signal()
    }
    
    func removeAllObjects() {
        self.semaphore.wait()
        self.array.removeAll()
        self.semaphore.signal()
    }
    
    /// contains
    func containsObject(_ object: EHICollectionCellModelType) -> Bool {
        self.semaphore.wait()
        let isContain = self.array.contains {
            return $0 == object
        }
        self.semaphore.signal()
        return isContain
    }
    
    /// replace
    func replaceObject(at index: Int, with object: EHICollectionCellModelType) {
        if index < self.count {
            self.setObject(object, at: index)
        }
    }
    
    func setObject(_ object: EHICollectionCellModelType, at indexedSubscript: Int) {
        self.semaphore.wait()
        self.array.insert(object, at: indexedSubscript)
        self.semaphore.signal()
    }
}

extension EHICellModelData: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
