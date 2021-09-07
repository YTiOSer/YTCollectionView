//
//  HTTPClient.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

struct HTTPClient {
    
    var responseHandle: HTTPClientProtocol?
    
    init(handle: HTTPClientProtocol?) {
        self.responseHandle = handle
    }
    
    func get(url: String) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let requestUrl = URL(string: url) else {return}
        let request = URLRequest(url: requestUrl)
        session.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                self.responseHandle?.onFailure(error: requestError)
            } else {
                /// 解析数据
                if let responseData = data, let any = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers), let dict = any as? [String: Any] {
                    self.responseHandle?.onSuccess(object: dict)
                }
            }
        }.resume()
    }
}
