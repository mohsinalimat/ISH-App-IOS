//
//  AllProductsForServicesViewController.swift
//  ISH
//
//  Created by Admin on 16/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD
import SDWebImage

class ServiceProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    private var userid = ""
    
    

    private struct Product{
        var prodID : String
        var img : String
        var prodName : String
        var prodPrice : String
        var wishlist : String
        var prodSku : String
    }

    
    var productid = ""
    var homeTitle = ""
    private var products = [Product]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if defaults.object(forKey: "userID") != nil{
            userid = defaults.string(forKey: "userID")!
        }
        
        
//        print(productid)
        SVProgressHUD.dismiss()
        
        self.navigationItem.title = homeTitle
        
      self.collectionView.collectionViewLayout = VerticalBlueprintLayout(
            itemsPerRow: 2.0,
            height: 300,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pcell")
        
        getProductsData()
        
    }
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: products[indexPath.row].img), completed: nil)
        cell.price.text = "₹"+products[indexPath.row].prodPrice
        cell.productName.text = products[indexPath.row].prodName
        
        if products[indexPath.row].wishlist == "0"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-empty-icon"), for: .normal)
        }else if products[indexPath.row].wishlist == "1"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-filled-icon"), for: .normal)
        }
        
        
        cell.wish = products[indexPath.row].wishlist
        cell.productID = products[indexPath.row].prodID
        cell.productSKU = products[indexPath.row].prodSku
        
        if userid != ""{
            cell.wishlistBtn.isHidden = false
        }
        
        cell.wishlistBtn.tag = indexPath.row
        cell.wishlistBtn.addTarget(self, action: #selector(self.wishlishtPressed(_:)), for: .touchUpInside)
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = navigationController {
            viewController.prodid = products[indexPath.row].prodID
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
    private func getProductsData(){
        
        SVProgressHUD.show()
        
        var parameter = ["hashkey":AppDelegate.apiKey, "cate_id" : productid]
        
        if userid != ""{
            parameter["cust_id"] = userid
        }
        
            alamofireRequest(url: "view_category_products.php", params: parameter) { (json, data) in
                do{
                    
                    self.products = [Product]()
                    
                    let category = try JSONDecoder().decode(CategoryProductsRoot.self, from: data)
                    
                    if category.success == "1"{
                        for x in category.categoryProduct{
                            
                            self.products.append(Product(prodID: x.ids, img: x.img, prodName: x.name, prodPrice: String(x.price), wishlist: x.wishlist, prodSku: x.sku))
                            
                        }
                    }else if category.success == "0"{
                        SVProgressHUD.showError(withStatus: category.message)
                    }
                    
                    SVProgressHUD.dismiss()
                    self.collectionView.reloadData()
                    
                    
                }catch{
                    print(error)
                }
            }
            
            
        
        
        
    }
    
    
    
    @objc func wishlishtPressed(_ sender: UIButton){
//        print(products[sender.tag].wishlist)
       
    if let userID = defaults.string(forKey: "userID"){
        
        if products[sender.tag].wishlist == "1"{
            products[sender.tag].wishlist = "0"
            changeWishlistBtn(pos: sender.tag)
            //remove from wishlist
            alamofireRequest(url: "wishlist_delete.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : products[sender.tag].prodID]) { (json, data) in
                if json["success"].stringValue == "1"{
                    
                    //                       self.wish = "0"
                }else{
                    //                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    self.products[sender.tag].wishlist = "1"
                    self.changeWishlistBtn(pos: sender.tag)
                }
            }
            
        }else if products[sender.tag].wishlist == "0"{
            products[sender.tag].wishlist = "1"
            changeWishlistBtn(pos: sender.tag)
            //add to wishlist
            alamofireRequest(url: "wishlist.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : products[sender.tag].prodID, "sku" : products[sender.tag].prodSku]) { (json, data) in
                if json["success"].stringValue == "1"{
                    
                    //                        self.wish = "1"
                }else{
                    //                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    self.products[sender.tag].wishlist = "0"
                    self.changeWishlistBtn(pos: sender.tag)
                }
            }
        }
    }
    
    
    
}


    private func changeWishlistBtn(pos : Int){
        let cell = self.collectionView.cellForItem(at: IndexPath(item: pos, section: 0)) as!
        ProductCollectionViewCell
        if self.products[pos].wishlist == "1"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-filled-icon"), for: .normal)        }else if self.products[pos].wishlist == "0"{
            cell.wishlistBtn.setImage(UIImage(named: "wishlist-empty-icon"), for: .normal)
        }
    }
    
    
}
