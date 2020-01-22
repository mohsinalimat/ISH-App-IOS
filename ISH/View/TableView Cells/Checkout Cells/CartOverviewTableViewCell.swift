//
//  CartOverviewTableViewCell.swift
//  ISH
//
//  Created by Admin on 31/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class CartOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var prodImg: UIImageView!
    
    @IBOutlet weak var prodName: UILabel!
    
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
