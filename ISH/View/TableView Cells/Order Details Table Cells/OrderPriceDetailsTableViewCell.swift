//
//  OrderPriceDetailsTableViewCell.swift
//  ISH
//
//  Created by Admin on 25/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class OrderPriceDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
