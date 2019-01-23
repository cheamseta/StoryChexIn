//
//  RoundShadowView.swift
//  ChexIn
//
//  Created by seta cheam on 12/28/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class RoundShadowView: UIImageView {
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 50).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor;
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path

            shadowLayer.shadowOffset = CGSize(width: 0, height: 5);
            shadowLayer.shadowRadius = 8;
            shadowLayer.shadowOpacity = 0.3;
            
            layer.masksToBounds = true
            clipsToBounds = true
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
