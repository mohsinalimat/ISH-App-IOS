//
//  FeaturedProductsCollectionViewCell.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import DOFavoriteButton

class FeaturedProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productWishlist: DOFavoriteButton!{
        didSet{
            self.addSubview(productWishlist)
        }
    }
    

}
