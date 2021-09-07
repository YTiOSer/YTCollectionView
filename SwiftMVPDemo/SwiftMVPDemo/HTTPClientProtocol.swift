//
//  HTTPClientProtocol.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

protocol HTTPClientProtocol {
    func onSuccess(object: Dictionary<String, Any>)
    func onFailure(error: Error)
}
