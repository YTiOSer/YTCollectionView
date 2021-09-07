//
//  EHICollectionReusableViewSwift.swift
//  EHICustomCollectionViewSwift
//
//  Created by 杨涛 on 2021/7/1.
//
//  UICollectionReusableView

import UIKit

class EHICollectionReusableViewSwift: UICollectionReusableView, EHICellReusableProtocol {
        
    /// 渐变色
    var gradientLayer: CAGradientLayer?
    
    /// 背景视图
    var decorationView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(gradientLayer: CAGradientLayer?, decorationView: UIView?) {
        self.init()
        self.gradientLayer = gradientLayer
        self.decorationView = decorationView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EHICollectionReusableViewSwift {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let `layoutAttributes` = layoutAttributes as? EHICollectionViewLayoutAttributesSwift {
            
            self.backgroundColor = .clear
            self.decorationView?.removeFromSuperview()
            self.decorationView = nil
            self.gradientLayer?.removeFromSuperlayer()
            self.gradientLayer = nil
            
            self.layer.masksToBounds = true
            self.layer.cornerRadius = layoutAttributes.ehi_cornerRadius ?? 0
            
            // 判断需要添加什么视图
            if let decorationViewTmp = layoutAttributes.decorationView {
                self.decorationView = decorationViewTmp
                if (self.decorationView?.frame.equalTo(.zero) ?? false) || (layoutAttributes.autoCalDecorationViewFrame ?? false) {
                    decorationViewTmp.frame = self.bounds
                }
                self.insertSubview(decorationViewTmp, at: 0)
            } else if let gradientLayerTmp = layoutAttributes.gradientLayer {
                self.gradientLayer = gradientLayerTmp
                layoutAttributes.gradientLayer?.frame = self.bounds
                self.layer.insertSublayer(gradientLayerTmp, at: 0)
            } else {
                self.backgroundColor = layoutAttributes.sectionBgColor
            }
        }
    }
}
