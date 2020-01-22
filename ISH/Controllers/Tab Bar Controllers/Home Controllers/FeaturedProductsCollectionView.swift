//
//  FeaturedProductsCollectionView.swift
//  ISH
//
//  Created by Admin on 15/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD
import SDWebImage

class FeaturedProductsCell : UICollectionViewCell{
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var price: UILabel!
    
    
    
    
}

class FeaturedProductsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //variables
    private var prodID = [String]()
    private var img = [String]()
    private var prodName = [String]()
    private var prodPrice = [String]()
    private var wishlist = [String]()
    private var prodSku = [String]()
    
    
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 2.0,
            height: 300,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        self.collectionViewLayout = blueprintLayout
        
        self.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pcell")
        
        SVProgressHUD.show()
        getFeaturedProducts()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if prodID.count <= 7 {
            return prodID.count ?? 1
        }else{
            return 8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: img[indexPath.row]), completed: nil)
        cell.price.text = "₹"+prodPrice[indexPath.row]
        cell.productName.text = prodName[indexPath.row]
        
        if wishlist[indexPath.row] == "0"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-empty-icon"), for: .normal)
        }else if wishlist[indexPath.row] == "1"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-filled-icon"), for: .normal)
        }
        
        cell.wishlistBtn.tag = indexPath.row
        cell.wishlistBtn.addTarget(self, action: #selector(self.wishlishtPressed(_:)), for: .touchUpInside)
   
        
        return cell
    }
    
    
    private func getFeaturedProducts(){
        if let userID = defaults.string(forKey: "userID"){
            
            alamofireRequest(url: "featured_product_home.php", params: ["hashkey":AppDelegate.apiKey, "cust_id":userID]) { (json, data) in
                do{
                    
                    self.prodID = [String]()
                    self.img = [String]()
                    self.prodName = [String]()
                    self.prodPrice = [String]()
                    self.wishlist = [String]()
                    self.prodSku = [String]()
                    
                    let featured = try JSONDecoder().decode(HomeFeaturedRoot.self, from: data)
                    
                    if featured.success == "1"{
                        for x in featured.featuredProduct{
                            self.prodID.append(x.id)
                            self.img.append(x.img)
                            self.prodName.append(x.name)
                            self.prodPrice.append(String(x.price))
                            self.wishlist.append(x.wishlist)
                            self.prodSku.append(x.sku)
                        }
                    }else if featured.success == "0"{
                        SVProgressHUD.showError(withStatus: featured.message)
                    }
                    
                    SVProgressHUD.dismiss()
//                    self.delegate = self
//                    self.dataSource = self
                    self.reloadData()
                    
                }catch{
                    print(error)
                }
            }
            
            
        }
    }
    
    
    @objc private func wishlishtPressed(_ sender: UIButton){ //<- needs `@objc`
        print(wishlist[sender.tag])
        
        if let userID = defaults.string(forKey: "userID"){
            
            
            
            
            //add to wishlist
            if wishlist[sender.tag] == "0"{
                alamofireRequest(url: "wishlist.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : prodID[sender.tag], "sku" : prodSku[sender.tag]]) { (json, data) in
                    if json["success"].stringValue == "1"{
                        
                        SVProgressHUD.showSuccess(withStatus: json["message"].stringValue)
                        self.getFeaturedProducts()
                    }else{
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    }
                }
            }//remove from wishlist
            else if wishlist[sender.tag] == "1"{
                alamofireRequest(url: "wishlist_delete.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : prodID[sender.tag]]) { (json, data) in
                    if json["success"].stringValue == "1"{
                        
                        SVProgressHUD.showSuccess(withStatus: json["message"].stringValue)
                        self.getFeaturedProducts()
                    }else{
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    }
                }
            }
            
            
        }
        
        
    }
    
}
