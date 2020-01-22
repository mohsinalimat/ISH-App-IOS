//
//  AddressesTableViewCell.swift
//  ISH
//
//  Created by Admin on 29/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class AddressesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
