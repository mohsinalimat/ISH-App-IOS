//
//  CartViewController.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD
import DropDown
import SwiftyJSON
import RealmSwift

class CartCell : UITableViewCell{
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var qtyBtn: UIButton!
    
    
    @IBOutlet weak var deleteBtn: UIButton!
}


struct Cart{
    
    var id : String
    var item_id : String
    var name : String
    var cart : String
    var sku : String
    var qty : String
    var price : String
    var image : String
    
}


class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func unwindToCart(segue:UIStoryboardSegue) {
        
        addToCart()
    }
    
    
    @IBOutlet weak var viewEmpty: UIView!{
        didSet{
            viewEmpty.isHidden = true
        }
    }
    
    @IBAction func StartShopingBtn(_ sender: UIButton) {
        
        goToPage(goto: "Home")
    }
    @IBOutlet weak var cartTotalLbl: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!{
        didSet{
            checkoutBtn.isHidden = true
        }
    }
    
    @IBAction func checkoutBtn(_ sender: UIButton) {
        
        if defaults.object(forKey: "userID") != nil{
            // Safe Push VC
            let viewController = UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "AddressVC") as! AddressBookTableViewController
            if let navigator = navigationController {
                viewController.cartItems = carts
                navigator.pushViewController(viewController, animated: true)
            }else{
                print("unable to navigate")
            }
        }else{
            self.performSegue(withIdentifier: "goToLogin", sender: self)
            
        }
        
        
        
        
        //        goToPage(goto: "Address")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    private var carts = [Cart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
       self.tableView.tableFooterView = UIView()
    

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        getBadgeValues()
        self.navigationController?.navigationBar.topItem?.title = "CART"
//        self.tableView.tableFooterView = CartView()
        viewEmpty.isHidden = true
         SVProgressHUD.show()
        if defaults.object(forKey: "userID") != nil{
            getCartData()
        }else{
            getOfflineCartData()
        }
        
    }
    
    
    
    
    private func getOfflineCartData(){
        self.checkoutBtn.isHidden = true
        var total = 0
        createRealmObj { (realm) in
            let cart = realm.objects(CartRealm.self)
            if cart.count != 0{
                self.carts = [Cart]()
                for x in cart{
                    self.carts.append(Cart(id: x.id, item_id: "", name: x.name, cart: x.cart, sku: x.sku, qty: x.qty, price: x.price, image: x.image))
                    total += Int(x.price)!
                }
                
                self.cartTotalLbl.text = String(total)
                self.checkoutBtn.isHidden = false
                
                self.tableView.reloadData()
//                self.tableView.tableFooterView = UIView()
//                self.viewEmpty.isHidden = true
            }else{
                self.carts = [Cart]()
                self.cartTotalLbl.text = "0"
                self.tableView.reloadData()
                
//                self.tableView.tableFooterView = CartView()
            }
            self.getBadgeValues()
            self.setEmptyCartView()
            SVProgressHUD.dismiss()
        }
        
        
    }
    
    
    
    private func getCartData(){
        SVProgressHUD.show()
        
        if let userID = defaults.string(forKey: "userID"){
            
            alamofireRequest(url: "cart_items.php", params: ["hashkey":AppDelegate.apiKey, "custid":userID]) { (json, data) in
                do{
                    self.carts = [Cart]()
                    
                    let prod = try JSONDecoder().decode(CartProductsRoot.self, from: data)
                    
                    if prod.success == "1"{
                        
                        if let products = prod.addtocart{
                            
                            for x in products{
                                
                                self.carts.append(Cart(id: x.id, item_id: x.itemID, name: x.name, cart: x.cart, sku: x.sku, qty: String(x.qty), price: String(x.price), image: x.image))
                                
                            }
                        }
                        
                        self.checkoutBtn.isHidden = false
                        
                        
                    }else if prod.success == "0" {
                        SVProgressHUD.showError(withStatus : prod.message)
                    }
                    
                    SVProgressHUD.dismiss()
                    self.getBadgeValues()
                    self.tableView.reloadData()
                    self.setEmptyCartView()
                    self.cartTotalLbl.text = String(prod.totalAmount)
                    
                }catch{
                    
                    print(error)
                }
            }
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return carts.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ccell", for: indexPath) as! CartCell
        cell.itemName.text = carts[indexPath.row].name
        cell.itemPrice.text = carts[indexPath.row].price
        cell.productImg.sd_setImage(with: URL(string: carts[indexPath.row].image), completed: nil)
        cell.qtyBtn.setTitle("\(carts[indexPath.row].qty) ▾", for: .normal)
        
        
        
        cell.deleteBtn.tag = indexPath.row
        cell.qtyBtn.tag = indexPath.row
        
        
        cell.qtyBtn.addTarget(self, action: #selector(self.quantityPressed(_:)), for: .touchUpInside)
        
        cell.deleteBtn.addTarget(self, action: #selector(self.removeFromCart(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc private func quantityPressed(_ sender: UIButton){ //<- needs `@objc`
        
        let dropDown = DropDown()
        
        dropDown.dataSource = ["1","2","3","4","5", "6", "7", "8", "9", "10"]
        dropDown.anchorView = sender
        dropDown.width = 50
        
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.show()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            sender.setTitle(item + " ▾", for: .normal)
            
            if defaults.object(forKey: "userID") != nil{
                self.updateCart(prodqty: item, prodid: self.carts[sender.tag].id)
                
            }else{
                
                createRealmObj(completion: { (realm) in
                    let cart = realm.objects(CartRealm.self)
                    print(sender.tag)
                    try! realm.write {
                        cart[sender.tag].qty = item
                        let qty : Int = Int(cart[sender.tag].qty)!
                        let pr : Int = Int(cart[sender.tag].regularPrice)!
                        cart[sender.tag].price = String(qty*pr)
                        self.getOfflineCartData()
                    }
                    
                })
                
                
            }
            
        }
    }
    
    private func updateCart(prodqty: String, prodid : String){
        
        if let userID = defaults.string(forKey: "userID"){
            SVProgressHUD.show()
            
//            print(JSON(["custid":userID, "cartProduct":[["prodqty":prodqty,"prodid":prodid]]]).rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.sortedKeys)!)
            
            alamofireCartRequest(url: "cart.php", params: ["hashkey" :AppDelegate.apiKey ,"cart":JSON(["custid":userID, "cartProduct":[["prodqty":prodqty,"prodid":prodid]]]).rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.sortedKeys)!]) { (json, data) in
                
                
                self.getCartData()
                
                
            }
            
        }
    }
    
    
    @objc private func removeFromCart(_ sender: UIButton){
        SVProgressHUD.show()
        
        
        if defaults.object(forKey: "userID") != nil{
            
            if let userID = defaults.string(forKey: "userID"){
                
                alamofireRequest(url: "cart_delete.php", params: ["hashkey":AppDelegate.apiKey, "custid" : userID, "itemid" : carts[sender.tag].item_id]) { (json, data) in
                    
                    if json["success"].stringValue == "1"{
                        self.getCartData()
                    }
                    
                }
                
                
            }
            
            
        }else{
            
            createRealmObj(completion: { (realm) in
                let cart = realm.objects(CartRealm.self)
                print(sender.tag)
                if cart.count != 0{
                    try! realm.write {
                        realm.delete(cart[sender.tag])
                        self.getOfflineCartData()
                    }
                }
            })
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin"{
            let vc = segue.destination as! LoginViewController
            vc.flag = "cart"
        }
    }
}


extension CartViewController{
    
    
    
    private func addToCart(){
        var  xa = [Any]()
        
        
        createRealmObj(completion: { (realm) in
            
            let cart = realm.objects(CartRealm.self)
            
            for x in cart{
                var cartProducts = [String:String]()
                cartProducts["prodqty"] = x.qty
                cartProducts["prodid"] = x.id
                xa.append(cartProducts)
            }
            
        })
        
        
        if defaults.object(forKey: "userID") != nil{


            if let userID = defaults.string(forKey: "userID"){
                SVProgressHUD.show()

                alamofireCartRequest(url: "cart.php", params: ["hashkey" :AppDelegate.apiKey ,"cart":JSON(["custid": userID, "cartProduct":xa]).rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.sortedKeys)!]) { (json, data) in

                    if json["success"].stringValue == "1"{
                        
                        createRealmObj(completion: { (realm) in
                            
                            let cart = realm.objects(CartRealm.self)
                            
                            try! realm.write {
                                realm.deleteAll()
                            }
                            
                            })
                        self.getCartData()
                    }
                    SVProgressHUD.dismiss()
                }

            }

        }
//
    }
    
    
    private func setEmptyCartView(){
        
        if carts.count != 0 {
            self.viewEmpty.isHidden = true
        }else{
            self.viewEmpty.isHidden = false
        }
        
        
        
    }
    
}
