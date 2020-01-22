//
//  WishlistViewController.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD
import Blueprints

class WishlistViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    private var goToLogin = false
    
    //variables
    private var prodID = [String]()
    private var img = [String]()
    private var prodName = [String]()
    private var prodPrice = [String]()
    private var wishlist = [String]()
    private var prodSku = [String]()
    
    
    
    @IBOutlet weak var viewEmpty: UIView!{
        didSet{
            viewEmpty.isHidden = true
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 2.0,
            height: 300,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        self.collectionView.collectionViewLayout = blueprintLayout
        
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pcell")
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewEmpty.isHidden = true
        
        if defaults.object(forKey: "userID") == nil{
//            print(goToLogin)
            if !goToLogin{
                
                self.goToPage(goto: "Login")
                goToLogin = !goToLogin
            }else{
                viewEmpty.isHidden = false
            }
            
        }else
        {
            getData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "WISHLIST"
        getBadgeValues()
    }
    
    
    
    private func getData(){
        
        if let userID = defaults.string(forKey: "userID"){
            SVProgressHUD.show()
            
            
            alamofireRequest(url: "wishlist_items.php", params: ["hashkey" : AppDelegate.apiKey,"custid" :userID]) { (json, data) in
                
                do{
                    
                    self.prodID = [String]()
                    self.img = [String]()
                    self.prodName = [String]()
                    self.prodPrice = [String]()
                    self.wishlist = [String]()
                    self.prodSku = [String]()
                    
                    let wish = try JSONDecoder().decode(WishlistRoot.self, from: data)
                    
                    if wish.success == "1"{
                        if let cart = wish.addtocart{
                            for x in cart{
                                self.prodID.append(x.id)
                                self.img.append(x.image)
                                self.prodName.append(x.name)
                                self.prodPrice.append(String(x.price))
                                self.wishlist.append(x.wishlist)
                                self.prodSku.append(x.sku)
                            }
                        }else{
                            SVProgressHUD.dismiss()
                        }
                        
                    }else if wish.success == "0"{
                        SVProgressHUD.showError(withStatus: wish.message)
                    }
                    
                    SVProgressHUD.dismiss()
                    self.getBadgeValues()
                    self.checkEmptyWishlist()
                    self.collectionView.reloadData()
                    
                }catch{
                    print(error)
                }
                
                
            }
            
            
        }
        
        
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prodID.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        cell.wishlistBtn.isHidden = false
        
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
        
        
        //        cell.addToCartBtn.isHidden = false
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = navigationController {
            viewController.prodid = prodID[indexPath.row]
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
    
    
    @objc private func wishlishtPressed(_ sender: UIButton){ //<- needs `@objc`
        print(wishlist[sender.tag])
        
        if let userID = defaults.string(forKey: "userID"){
            
            if wishlist[sender.tag] == "1"{
                alamofireRequest(url: "wishlist_delete.php", params: ["hashkey" : AppDelegate.apiKey, "custid" : userID, "prodid" : prodID[sender.tag]]) { (json, data) in
                    if json["success"].stringValue == "1"{
                        
                        SVProgressHUD.showSuccess(withStatus: json["message"].stringValue)
                        self.getData()
                    }else{
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    }
                }
            }
            
            
        }
        
        
    }
    
    private func checkEmptyWishlist(){
        
        if prodID.count != 0 {
            self.viewEmpty.isHidden = true
        }else{
            self.viewEmpty.isHidden = false
        }
        
        
    }
    
}
