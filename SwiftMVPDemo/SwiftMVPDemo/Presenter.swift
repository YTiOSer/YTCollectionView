//
//  Presenter.swift
//  SwiftMVPDemo
//
//  Created by 杨涛 on 2021/4/7.
//

import Foundation

protocol Presenter {
    associatedtype T
    var view: T? {get set}
    mutating func initial(_ view: T)
}
