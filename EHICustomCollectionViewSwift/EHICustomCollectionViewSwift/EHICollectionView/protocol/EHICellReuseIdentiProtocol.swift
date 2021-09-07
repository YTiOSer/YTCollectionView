//
//  EHICellReuseIdentiProtocol.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/29.
//
//  cell复用

import UIKit

protocol EHICellReusableProtocol {
    static var reuseableIdentifier: String { get }
    static var nib: UINib? { get }
    static func cellHeight() -> CGFloat
}

extension EHICellReusableProtocol where Self: UITableViewCell {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension EHICellReusableProtocol where Self: UICollectionViewCell {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension EHICellReusableProtocol where Self: UICollectionReusableView {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

extension EHICellReusableProtocol where Self: UITableViewHeaderFooterView {
    static var reuseableIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: self.reuseableIdentifier, bundle: nil) }
    static func cellHeight() -> CGFloat { return 44 }
}

