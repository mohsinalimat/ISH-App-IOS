//
//  ImageTitleandPriceTableViewCell.swift
//  ISH
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class ImageTitleandPriceTableViewCell: UITableViewCell {
    
    var prodid = ""
    var sku = ""
    var wish = ""
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var wishlistBtn: UIButton!
    
    @IBAction func wishlistBtn(_ sender: UIButton) {
        //        print("here")
        
        if prodid != "" && sku != "" && wish != ""{
            if let userID = defaults.string(forKey: "userID"){
                
                if wish == "1"{
                    wish = "0"
                    changeWishlistBtn()
                    //remove from wishlist
                    alamofireRequest(url: "wishlist_delete.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : self.prodid]) { (json, data) in
                        if json["success"].stringValue == "1"{
                            
                            //                       self.wish = "0"
                        }else{
                            SVProgressHUD.showError(withStatus: json["message"].stringValue)
                            self.wish = "1"
                            self.changeWishlistBtn()
                        }
                    }
                    
                }else if wish == "0"{
                    wish = "1"
                    changeWishlistBtn()
                    //add to wishlist
                    alamofireRequest(url: "wishlist.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : self.prodid, "sku" : self.sku]) { (json, data) in
                        if json["success"].stringValue == "1"{
                            
                            //                        self.wish = "1"
                        }else{
                            SVProgressHUD.showError(withStatus: json["message"].stringValue)
                            self.wish = "0"
                            self.changeWishlistBtn()
                        }
                    }
                }
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if defaults.object(forKey: "userID") != nil{
            self.wishlistBtn.isHidden = false
        }else{
            self.wishlistBtn.isHidden = true
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func changeWishlistBtn(){
        
        if wish == "0"{
            wishlistBtn.setImage(UIImage(named: "wishlist-empty-icon"), for: .normal)
        }else if wish == "1"{
            wishlistBtn.setImage(UIImage(named: "wishlist-filled-icon"), for: .normal)
        }
        
        
    }
    
    
}
