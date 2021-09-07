//
//  SwiftTest.swift
//  OcAndSwiftMixCodeTest
//
//  Created by 杨涛 on 2021/2/1.
//  Copyright © 2021 杨涛. All rights reserved.
//

import UIKit

@objcMembers class SwiftTest: NSObject {

    // OC类
    var ocViewController: ViewController?
    // 测试闭包
    var textClosures = {}
       
    override init() {
        super.init()
    }
       
    func textOcBlock() {
        self.ocViewController = ViewController()
        self.ocViewController?.myblock = { name in
               print(name ?? "")
        }
    }
}

/// KVO
class Observer: NSObject {
      override func observeValue(forKeyPath keyPath: String?,
                     of object: Any?,
                     change: [NSKeyValueChangeKey : Any]?,
                     context: UnsafeMutableRawPointer?) {
          print("observeValue", change?[.newKey] as Any)
      }
}

/// runtime
class Car: NSObject {

    @objc dynamic var name: String = ""
    var observer: Observer = Observer()

    override init() {
        super.init()
        self.addObserver(observer,
            forKeyPath: "BMW",
            options: .new,
            context: nil
        )
    }

    deinit {
        self.removeObserver(observer,forKeyPath: "name")
    }
}

/// KVO、KVC
class CarK: NSObject {
     @objc dynamic var name: String = ""
     var observation: NSKeyValueObservation?
     override init() {
         super.init()
         observation = observe(\CarK.name, options: .new) {
             (car, change) in
            print(change.newValue ?? "")
         }
     }
}

class TextCar: NSObject {
    
    var car = CarK()
    // Optional(20)
    
    func text() {
        car.name = "BMW"
        // Optional(25)
        car.setValue("BBA", forKey: "name")
    }
}


@objc enum CarType: Int {
    case baoma = 0
    case benchi
}

/// 结构体
struct CarStruct {
    
    var name: String?
    var price: Int?
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

@objcMembers class CarClass: NSObject {
    
    var car = CarStruct(name: "BMW", price: 30)
    
    func getCarName() -> String {
        return car.name ?? ""
    }
    
    func getCarPrice() -> Int {
        return car.price ?? 0
    }
}

/// 测试高阶函数
@objcMembers class TextHighFunction: NSObject {
    
    var array = [1, 2, 3, 4, 5]
    
    func functionHandle() {
        print(array.filter({ (item) -> Bool in
            item > 2
        }))
    }
}
