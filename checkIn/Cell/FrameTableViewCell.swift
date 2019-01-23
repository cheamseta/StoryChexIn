//
//  FrameTableViewCell.swift
//  ChexIn
//
//  Created by seta cheam on 12/31/18.
//  Copyright © 2018 seta cheam. All rights reserved.
//

import UIKit

class FrameTableViewCell: UITableViewCell {
    
    
    @IBOutlet var theImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theImgView.layer.cornerRadius = 40;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
