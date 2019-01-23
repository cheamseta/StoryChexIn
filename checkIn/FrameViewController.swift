//
//  FrameViewController.swift
//  ChexIn
//
//  Created by seta cheam on 12/27/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class FrameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var theTableView: UITableView!
    
    var frames : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
    }
    
    func setupTable() {
    
        let serve : Services = Services();
        
        self.frames = serve.frames();
        
        self.theTableView.delegate = self;
        self.theTableView.dataSource = self;
        
        let nibCell = UINib(nibName: "FrameTableViewCell", bundle: nil);
        self.theTableView.register(nibCell, forCellReuseIdentifier: "FrameTableViewCell");

    
    }
    

    @objc func nextView(sender : Any) {
        

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : FrameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FrameTableViewCell", for: indexPath) as! FrameTableViewCell;
        
        let row : NSDictionary  = self.frames.object(at: indexPath.row) as! NSDictionary
     
        cell.theImgView.image = UIImage(named: row.object(forKey: "thumb") as! String);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let row : NSDictionary  = self.frames.object(at: indexPath.row) as! NSDictionary
        
        let styleList : StyleListViewController = StyleListViewController();
        styleList.frameImage = UIImage(named: row.object(forKey: "img") as! String);
        self.navigationController?.pushViewController(styleList, animated: true);
        
    }

}
