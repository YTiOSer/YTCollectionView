//
//  CacheModel.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

struct CacheModel {
    
    var origin: String?
    var url: String?
    
    static func fromJSON(_ dictionary: [String: Any]?) -> CacheModel? {
        if let json = dictionary {
            var model = CacheModel()
            model.origin = json["origin"] as? String
            model.url = json["url"] as? String
            return model
        }
        return nil
    }
}
