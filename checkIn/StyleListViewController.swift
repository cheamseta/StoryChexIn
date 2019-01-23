//
//  StyleListViewController.swift
//  ChexIn
//
//  Created by seta cheam on 11/22/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class StyleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var style : NSArray!
    var frameImage : UIImage!
   
    @IBOutlet var theTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map Style";
        
        let serv : Services = Services()
        self.style = serv.styles() as NSArray;
        
        let nip = UINib(nibName: "FrameTableViewCell", bundle: nil)
        self.theTableView.register(nip, forCellReuseIdentifier: "FrameTableViewCell");

        self.theTableView.delegate = self;
        self.theTableView.dataSource = self;


    }
    
    @objc func dismiss(sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 300;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return style.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : FrameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FrameTableViewCell", for: indexPath) as! FrameTableViewCell
        
        let stringMap : String = "map" + String(indexPath.row + 1)  + ".jpg";
        
        cell.theImgView.image = UIImage(named: stringMap);
 
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mapView : MapSaveViewController = MapSaveViewController();
        mapView.frameImage = self.frameImage;
        mapView.currIndex = indexPath.row;
        self.navigationController?.pushViewController(mapView, animated: true);
        
//        self.dismiss(animated: true,  completion: nil);
//        self.delegate?.didSelectTable(index: indexPath.row);
    
        
    }
    

}
