//
//  YTCellReuseIdentiProtocol.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/29.
//
//  cell复用

import UIKit

protocol YTCellReusableProtocol {
    static var reuseableIdentifier: String { get }
    static var nib: UINib? { get }
    static func cellHeight() -> CGFloat
}

extension YTCellReusableProtocol where Self: UITableViewCell {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension YTCellReusableProtocol where Self: UICollectionViewCell {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension YTCellReusableProtocol where Self: UICollectionReusableView {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension YTCellReusableProtocol where Self: UITableViewHeaderFooterView {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

