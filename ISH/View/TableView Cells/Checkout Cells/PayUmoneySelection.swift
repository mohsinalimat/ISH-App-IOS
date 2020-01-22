//
//  PayUmoneySelection.swift
//  ISH
//
//  Created by Admin on 17/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import DLRadioButton

class PayUmoneySelection: UITableViewCell {

    @IBOutlet private var cardRBtn : DLRadioButton!
    @IBOutlet private var codRBtn : DLRadioButton!
    
    @IBAction func cardBtn(_ sender: UIButton) {
        cardRBtn.isSelected = true
        CheckoutTableViewController.checkoutMethod = "payu"
        
    }
    @IBAction func codBtn(_ sender: UIButton) {
        codRBtn.isSelected = true
        CheckoutTableViewController.checkoutMethod = "cashondelivery"
    }
    @IBAction func cardRBtn(_ sender: DLRadioButton) {
        
        CheckoutTableViewController.checkoutMethod = "payu"
    }
    
    @IBAction func codRBtn(_ sender: DLRadioButton) {
    
        CheckoutTableViewController.checkoutMethod = "cashondelivery"
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
