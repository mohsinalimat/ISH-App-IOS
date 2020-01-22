//
//  AccountViewController.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
import AlamofireImage
import Alamofire

class AccountCell : UITableViewCell{
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
}


class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func unwindToAccount(segue:UIStoryboardSegue) {
        
        addToCart()
    }
    
    private struct Account{
        var img : UIImage
        var title : String
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var accountData = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "MY ACCOUNT"
        
        getBadgeValues()
        
        if defaults.object(forKey: "userID") != nil{
            accountData = [Account(img: UIImage(named: "account-franchise-icon")!, title: "My Franchise"),
                           Account(img: UIImage(named: "account-wallet-icon")!, title: "My Wallet"),
                           Account(img: UIImage(named: "wishlist-filled-icon")!, title: "My Wishlist"),
                           Account(img: UIImage(named: "account-shopping-bag-icon")!, title: "My Orders"),
                           Account(img: UIImage(named: "account-myaccount-icon")!, title: "Account Information")]
            
        }else{
            accountData = [Account(img: UIImage(named: "account-myaccount-icon")!, title: "Login")]
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acell", for: indexPath) as! AccountCell
        cell.imgView.image = accountData[indexPath.row].img
        cell.titleLbl.text = accountData[indexPath.row].title
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if accountData[indexPath.row].title == "Login"{
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            if let navigator = navigationController {
                viewController.flag = "account"
                navigator.pushViewController(viewController, animated: true)
            }else{
                print("unable to navigate")
            }
        }else{
            goToPage(goto: accountData[indexPath.row].title)
        }
    }
    
    
    
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
                        //                        self.getCartData()
                    }
                    SVProgressHUD.dismiss()
                }
                
            }
            
        }
        //
    }
   
}
