//
//  YTCollectionViewLayoutAttributesSwift.swift
//  YTCustomCollectionViewSwift
//
//  Created by yt on 2021/6/22.
//

import UIKit

class YTCollectionViewLayoutAttributesSwift: UICollectionViewLayoutAttributes {

    /// 背景色
    var sectionBgColor: UIColor?
    
    /// 渐变色
    var gradientLayer: CAGradientLayer?
    
    /// 装饰视图-圆角
    var yt_cornerRadius: CGFloat?
    
    /// 自定义背景视图
    var decorationView: UIView?
    
    /// 是否用自动计算好的frame
    var autoCalDecorationViewFrame: Bool?
    
    func isEqual(_ object: UICollectionViewLayoutAttributes?) -> Bool {
        
        guard let `object` = object else {return false}
        
        if let tmp = object as? YTCollectionViewLayoutAttributesSwift {
            
            if self.yt_cornerRadius != tmp.yt_cornerRadius {
                return false
            }
            if let bgColor = self.sectionBgColor, !bgColor.isEqual(tmp.sectionBgColor) {
                return false
            }
            if self.gradientLayer != tmp.gradientLayer {
                return false
            }
            if self.autoCalDecorationViewFrame != tmp.autoCalDecorationViewFrame {
                return false
            }
        }
        
        return super.isEqual(object)
    }
}
