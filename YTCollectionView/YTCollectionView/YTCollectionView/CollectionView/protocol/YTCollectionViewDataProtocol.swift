//
//  YTCollectionViewDataProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/23.
//
//  数据处理协议

import UIKit

protocol YTCollectionViewDataProtocol: NSObjectProtocol {
    
    /// 关联类型
    associatedtype itemType
    
    /// 信号量
    var semaphore: DispatchSemaphore {get set}
    
    /// 数组
    var array: Array<itemType> {get set}
    
    var count: Int {get set}
    
    /// 返回对应索引对象
    func object(at index: Int) -> itemType
    
    func objectAtIndexedSubscript(_ index: Int) -> itemType
    
    func addObject(_ object: itemType)
    
    func insertObject(_ object: itemType, at index: Int)
    
    func sortIndex()
    
    func removeObject(at index: Int)
    
    func removeObject(_ object: itemType)
    
    func removeAllObjects()
    
    func containsObject(_ object: itemType) -> Bool
    
    func replaceObject(at index: Int, with object: itemType)
    
    func setObject(_ object: itemType, at indexedSubscript: Int)
}

extension YTCollectionViewDataProtocol {
    
    var semaphore: DispatchSemaphore {
        get {
            return DispatchSemaphore(value: 1)
        }
        set {
            self.semaphore = newValue
        }
    }
    
    var array: Array<itemType> {
        get {
            return []
        }
        set {
            self.array = newValue
        }
    }
    
    var count: Int {
        get {
            return self.array.count
        }
        set {
            self.count = newValue
        }
    }
}

extension YTCollectionViewDataProtocol {
    
    func getCount() -> Int {
        return self.array.count
    }
    
    func object(at index: Int) -> itemType {
        self.semaphore.wait()
        let object = self.array[index]
        self.semaphore.signal()
        return object
    }
    
    func objectAtIndexedSubscript(_ index: Int) -> itemType {
        return self.object(at: index)
    }
    
    func addObject(_ object: itemType) {
        self.insertObject(object, at: self.count)
    }
    
    func insertObject(_ object: itemType, at index: Int) {
        self.semaphore.wait()
        self.array.insert(object, at: index)
        self.sortIndex()
        self.semaphore.signal()
    }
    
    func removeObject(at index: Int) {
        self.semaphore.wait()
        self.array.remove(at: index)
        self.sortIndex()
        self.semaphore.signal()
    }
    
    func removeAllObjects() {
        self.semaphore.wait()
        self.array.removeAll()
        self.semaphore.signal()
    }
    
    func replaceObject(at index: Int, with object: itemType) {
        if index < self.count {
            self.setObject(object, at: index)
        }
    }
    
    func setObject(_ object: itemType, at indexedSubscript: Int) {
        self.semaphore.wait()
        self.array.insert(object, at: indexedSubscript)
        self.semaphore.signal()
    }
    
    func sortIndex() {}
}

