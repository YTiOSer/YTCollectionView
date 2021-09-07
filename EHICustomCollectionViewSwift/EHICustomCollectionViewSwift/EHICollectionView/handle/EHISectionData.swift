//
//  EHISectionData.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/23.
//
//  sectionItem数据源

import UIKit

class EHISectionData: NSObject {
    
    convenience init(array: [EHICollectionSectionItemType]) {
        self.init()
        self.semaphore.wait()
        self.array = array
        self.semaphore.signal()
    }

    /// 信号量
    lazy var semaphore: DispatchSemaphore = {
        return DispatchSemaphore.init(value: 1)
    }()
    
    /// 数组
    lazy var array: Array<EHICollectionSectionItemType> = {
        return []
    }()
}

// MARK: 获取
extension EHISectionData {
    
    func object(at index: Int) -> EHICollectionSectionItemType {
        self.semaphore.wait()
        let obj = self.array[index]
        self.semaphore.signal()
        return obj
    }
    
    func objectAtIndexedSubscript(_ index: Int) -> EHICollectionSectionItemType {
        return self.object(at: index)
    }
    
    func removeFirstObject() {
        if self.array.count > 0 {
            self.array.removeFirst()
        }
    }
    
    func removeLastObject() {
        if self.array.count > 0 {
            self.array.removeLast()
        }
    }
}

extension EHISectionData: EHICollectionViewDataProtocol {
    
    func containsObject(_ object: EHICollectionSectionItemType) -> Bool {
        self.semaphore.wait()
        let isContain = self.array.contains {
            return $0 == object
        }
        self.semaphore.signal()
        return isContain
    }
    
    func removeObject(_ object: EHICollectionSectionItemType) {
        self.semaphore.wait()
        for i in 0..<self.array.count {
            let item = self.array[i]
            if (item.isEqual(object)) {
                self.array.remove(at: i)
                break
            }
        }
        self.semaphore.signal()
    }
}
 
