//
//  OurServicesCollectionViewCell.swift
//  ISH
//
//  Created by Admin on 17/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

class OurServicesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.changeToCircularImageView()
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
