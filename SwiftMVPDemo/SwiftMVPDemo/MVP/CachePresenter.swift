//
//  CachePresenter.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import Foundation

struct CachePresenter<U> where U: CacheProtocol {
    
    var viewControler: U?
    var httpClient: HTTPClient?
    typealias Value = Int
    
    mutating func initial(_ viewControler: U) {
        self.viewControler = viewControler
        /// 初始化HTTPClient
        self.httpClient = HTTPClient(handle: self)
    }
    
    func getCache(by integer: Value) {
        /// 网络请求
        self.httpClient?.get(url: "http://httpbin.org/cache/\(integer)")
    }
}

/// 实现HTTPClientProtocol协议
extension CachePresenter: HTTPClientProtocol {
    func onSuccess(object: Dictionary<String, Any>) {
        viewControler?.getCacheSuccess(model: CacheModel.fromJSON(object))
    }
    
    func onFailure(error: Error) {
        print(error)
    }
}

extension CachePresenter: Presenter {
    var view: U? {
        get {
            return self.viewControler
        }
        set {
            self.viewControler = newValue
        }
    }
}
