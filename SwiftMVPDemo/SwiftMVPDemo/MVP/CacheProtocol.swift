//
//  CacheProtocol.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import UIKit

/// VC实现
protocol CacheProtocol {
    func getCacheSuccess(model: CacheModel?)
    func getCacheFailure(error: Error)
}
