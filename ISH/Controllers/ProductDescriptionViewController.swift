//
//  ProductDescriptionViewController.swift
//  ISH
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON


class ProductDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var cellexpanded = false
    
    var prodid = ""
    
    private var userid = ""
    
    
    private struct Product{
        var img = ""
        var sku = ""
        var desc = ""
        var price = ""
        var name = ""
        var id = ""
        var cart = ""
        var wishlist = ""
        var available = ""
    }
    
    private var prod : Product!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartBtn: UIButton!{
        didSet{
            cartBtn.isHidden = true
        cartBtn.backgroundColor = UIColor.flatOrangeDark
        }
        
    }
    @IBAction func cartBtn(_ sender: UIButton) {
        
        if prod.cart == "0"{
            
            if defaults.object(forKey: "userID") != nil{
             
            
            if let userID = defaults.string(forKey: "userID"){
                
                SVProgressHUD.show()
                alamofireCartRequest(url: "cart.php", params: ["hashkey" :AppDelegate.apiKey ,"cart":JSON(["custid":userID, "cartProduct":[["prodqty":"1","prodid":prodid]]]).rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.sortedKeys)!]) { (json, data) in
                    
                    if json["success"].stringValue == "1"{
                        self.prod.cart = "1"
                        self.cartBtn.backgroundColor = UIColor.flatGreenDark
                        self.cartBtn.setTitle("Go To Cart", for: .normal)
                        
                    }
                    SVProgressHUD.dismiss()
                }
                
                }
                
            }else{
                print("here")
                let cart = CartRealm()
                
                cart.image = prod.img
                cart.id = prod.id
                
                cart.name = prod.name
                cart.cart = "1"
                cart.sku = prod.sku
                cart.qty = "1"
                cart.price = prod.price
                cart.regularPrice = prod.price
                
                createRealmObj { (realm) in
                    try! realm.write {
                        realm.add(cart)
                        self.prod.cart = "1"
                        self.cartBtn.backgroundColor = UIColor.flatGreenDark
                        self.cartBtn.setTitle("Go To Cart", for: .normal)
                        
                    }
                }
                
            }
        }else{
            goToPage(goto: "My Cart")
        }
        
    }
    @IBAction func buyNowBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var buyNowBtn: UIButton!{
        didSet{
            buyNowBtn.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if defaults.object(forKey: "userID") != nil{
            userid = defaults.string(forKey: "userID")!
        }
        

        SVProgressHUD.dismiss()
        getData()
        
//        print("hjaekhrkajh")
        self.navigationItem.title = "ISH"
        
        self.tableView.register(UINib(nibName: "ImageTitleandPriceTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "dcell")
    }
    
    
   
    
    private func getData(){
       
        SVProgressHUD.show()
        
       var parameter = ["hashkey":AppDelegate.apiKey, "product_id" : prodid]
        
        if userid != ""{
            parameter["custid"] = userid
        }
        
        
        
        
        alamofireRequest(url: "productView.php", params: parameter ) { (json, data) in
                do{
                    
                    let desc = try JSONDecoder().decode(ProductDescriptionRoot.self, from: data)
                    
                    if desc.success == "1"{
                        for x in desc.product{
                            
                           self.prod = Product(img: x.image, sku: x.sku, desc: x.shortdescription, price: String(x.price), name: x.name, id: x.id, cart: x.cart, wishlist: x.wishlist, available: x.avalable)
                            
                            
            
                            
                        }
                        
                        
                    }else if desc.success == "0"{
                        SVProgressHUD.showError(withStatus: desc.message)
                    }
                    
                    
                    
                    
                    if self.prod.cart != "0"{
                        self.cartBtn.backgroundColor = UIColor.flatGreenDark
                        self.cartBtn.setTitle("Go To Cart", for: .normal)
                    }
                    
                    
                    self.cartBtn.isHidden = false
                    SVProgressHUD.dismiss()
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    
                    
                    
                    createRealmObj { (realm) in
                        let prod = realm.objects(CartRealm.self).filter("id == '\(self.prodid)'")
                        if prod.count != 0{
                            self.prod.cart = "1"
                            self.cartBtn.backgroundColor = UIColor.flatGreenDark
                            self.cartBtn.setTitle("Go To Cart", for: .normal)
                        }
                    }
                    
                    
                }catch{
                    print(error)
                }
            }
        
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageTitleandPriceTableViewCell
        
        cell.wish = prod.wishlist
        cell.prodid = prod.id
        cell.sku = prod.sku
        
        cell.changeWishlistBtn()
        
        cell.priceLbl.text = prod.price
        cell.titleLbl.text = prod.name
        cell.imgView.sd_setImage(with: URL(string: prod.img), completed: nil)
        return cell
        default : let cell = tableView.dequeueReusableCell(withIdentifier: "dcell", for: indexPath) as! DescriptionTableViewCell
        
            cell.descTV.text = prod.desc
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0 : return 370
        default : return 250
        
        }
    }
    
}
