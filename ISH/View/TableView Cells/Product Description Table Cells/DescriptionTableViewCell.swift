//
//  DescriptionTableViewCell.swift
//  ISH
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descTV: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
