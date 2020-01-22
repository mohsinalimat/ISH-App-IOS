//
//  OrderItemsTableViewCell.swift
//  ISH
//
//  Created by Admin on 25/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
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
