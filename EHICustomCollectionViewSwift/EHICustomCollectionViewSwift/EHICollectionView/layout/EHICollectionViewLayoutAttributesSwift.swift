//
//  EHICollectionViewLayoutAttributesSwift.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/6/22.
//

import UIKit

class EHICollectionViewLayoutAttributesSwift: UICollectionViewLayoutAttributes {

    /// 背景色
    var sectionBgColor: UIColor?
    
    /// 渐变色
    var gradientLayer: CAGradientLayer?
    
    /// 装饰视图-圆角
    var ehi_cornerRadius: CGFloat?
    
    /// 自定义背景视图
    var decorationView: UIView?
    
    /// 是否用自动计算好的frame
    var autoCalDecorationViewFrame: Bool?
    
    func isEqual(_ object: UICollectionViewLayoutAttributes?) -> Bool {
        
        guard let `object` = object else {return false}
        
        if let tmp = object as? EHICollectionViewLayoutAttributesSwift {
            
            if self.ehi_cornerRadius != tmp.ehi_cornerRadius {
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
