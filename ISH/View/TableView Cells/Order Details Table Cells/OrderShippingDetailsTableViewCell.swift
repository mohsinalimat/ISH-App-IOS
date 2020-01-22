//
//  OrderShippingDetailsTableViewCell.swift
//  ISH
//
//  Created by Admin on 25/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class OrderShippingDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var contryLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
