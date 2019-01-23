//
//  WalkthroughViewController.swift
//  ChexIn
//
//  Created by seta cheam on 11/28/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.setupScrollView();
    }

    func setupScrollView () {
    
        
        let scrollView :UIScrollView = UIScrollView(frame: UIScreen.main.bounds);
        scrollView.isPagingEnabled = true;
        self.view .addSubview(scrollView);
        
      
        let cgrect1 : CGRect = CGRect(x:0, y: 0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height);
        
        let firstView : UIView = UIView(frame: cgrect1);
        firstView.backgroundColor = UIColor.darkGray;
        
        let cgrect : CGRect = CGRect(x:UIScreen.main.bounds.width, y: 0,width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height);
        
        let secondView : UIView = UIView(frame: cgrect);
        secondView.backgroundColor = UIColor.darkGray;
        
        let label1 : UILabel = UILabel(frame: cgrect1);
        label1.textAlignment = .left;
        label1.numberOfLines = 0;
        label1.textColor = UIColor.white;
        label1.font = UIFont(name: "Avenir Next", size: 40);
        label1.text = "SHARE YOUR LOCATION\nON INSTAGRAM STORY"
        firstView.addSubview(label1);
        
        let label2 : UILabel = UILabel(frame: cgrect1);
        label2.textAlignment = .left;
        label2.numberOfLines = 0;
        label2.textColor = UIColor.white;
        label2.font = UIFont(name: "Avenir Next", size: 40);
        label2.text = "VERY SIMPLE WITH\nChexIn"
        secondView.addSubview(label2);
        
        let cgrecbutton : CGRect = CGRect(x:UIScreen.main.bounds.width * 2, y: 0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height);
        
        
        let button : UIButton = UIButton(frame: cgrecbutton);
        button.setTitle("Tap here TO GET STARTED", for: UIControl.State.normal)
        
        button.backgroundColor = UIColor.darkGray;
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20);
        button.addTarget(self, action: #selector(onDismiss(sender:)), for: UIControl.Event.touchUpInside);

        secondView.addSubview(label2);
        
        scrollView.addSubview(firstView);
        scrollView.addSubview(secondView);
            scrollView.addSubview(button);
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height);
        
        let labelSwipt : UILabel = UILabel(frame: CGRect(x: 20, y: 40, width: 200, height: 30));
        labelSwipt.textAlignment = .left;
        labelSwipt.numberOfLines = 0;
        labelSwipt.textColor = UIColor.white;
        labelSwipt.font = UIFont(name: "Avenir Next", size: 12);
        labelSwipt.text = "SWIPT RIGHT ..."
        self.view.addSubview(labelSwipt);
        
    }
    
    @objc func onDismiss(sender:Any) {
        self.dismiss(animated: true, completion: nil);
    }

}
