//
//  BLEProgressView.swift
//  BLEProgressView
//
//  Created by Shinya Yamamoto on 2018/01/25.
//  Copyright © 2018年 Shinya Yamamoto. All rights reserved.
//

import UIKit

class BLEProgressView :UIView {
    
    private var circleArray = [UIView(), UIView(), UIView(), UIView()]
    private var bleImageView:UIImageView = UIImageView()
    
    private var profileImg : UIImage!
    
    func initProfileImg (profileImg : UIImage) {
        self.profileImg = profileImg;
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        let bleColor = UIColor.clear;
        let scale = CGFloat(CGFloat(circleArray.count) + 1)
        let duration = TimeInterval(circleArray.count)
        var delay = 0.5
        for circle in circleArray {
            set(view: circle)
            circle.backgroundColor = bleColor;
            circle.layer.borderColor = self.getRandomColor().cgColor;
            circle.layer.borderWidth = 2;
            self.addSubview(circle)
            UIView.animate(withDuration: duration, delay: delay, options: .repeat, animations: { () -> Void in
                circle.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                circle.alpha = 0.0
            }, completion: nil)
            delay += 1
        }
        bleImageView.image = self.profileImg
        bleImageView.frame = CGRect(x:0,y:0,width:self.bounds.size.width,height:self.bounds.size.height)
        bleImageView.center = self.center
        bleImageView.roundMe();
        bleImageView.borderMe(borderSize: 2);
        self.addSubview(bleImageView)
        
    }
    
    private func set(view:UIView) {
        view.frame = CGRect(x:0,y:0,width:self.bounds.size.width - 20,height:self.bounds.size.height - 20)
        view.center = self.center
        view.layer.cornerRadius = (self.bounds.size.width - 20) / 2
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
 
    private func color(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
    }
}
