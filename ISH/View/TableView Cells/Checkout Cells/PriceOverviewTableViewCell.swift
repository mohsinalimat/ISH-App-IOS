//
//  PriceOverviewTableViewCell.swift
//  ISH
//
//  Created by Admin on 31/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class PriceOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var grossPrice: UILabel!
    @IBOutlet weak var cgst: UILabel!
    @IBOutlet weak var sgst: UILabel!
    @IBOutlet weak var shipping: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
