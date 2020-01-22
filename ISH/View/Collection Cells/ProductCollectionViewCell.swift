//
//  ProductCollectionViewCell.swift
//  ISH
//
//  Created by Admin on 16/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import DOFavoriteButton

class ProductCollectionViewCell: UICollectionViewCell {
    
    var wish = ""
    var productID = ""
    var productSKU = ""
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    
    @IBAction func wishlistBtn(_ sender: UIButton) {
        
        print(wish,productID,productSKU)
    }
//        if let userID = defaults.string(forKey: "userID"){
//
//            if wish == "1"{
//                wish = "0"
//                changeWishlistBtn()
//                //remove from wishlist
//                alamofireRequest(url: "wishlist_delete.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : self.productID]) { (json, data) in
//                    if json["success"].stringValue == "1"{
//
//                        //                       self.wish = "0"
//                    }else{
////                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
//                        self.wish = "1"
//                        self.changeWishlistBtn()
//                    }
//                }
//
//            }else if wish == "0"{
//                wish = "1"
//                changeWishlistBtn()
//                //add to wishlist
//                alamofireRequest(url: "wishlist.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : self.productID, "sku" : self.productSKU]) { (json, data) in
//                    if json["success"].stringValue == "1"{
//
//                        //                        self.wish = "1"
//                    }else{
////                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
//                        self.wish = "0"
//                        self.changeWishlistBtn()
//                    }
//                }
//            }
//        }
//
//
//
//    }
//
//
//    func changeWishlistBtn(){
//
//        if wish == "0"{
//            wishlistBtn.setImage(UIImage(named: "wishlist-empty-icon"), for: .normal)
//        }else if wish == "1"{
//            wishlistBtn.setImage(UIImage(named: "wishlist-filled-icon"), for: .normal)
//        }
//
//
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
