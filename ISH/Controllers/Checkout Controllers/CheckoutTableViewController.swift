//
//  CheckoutTableViewController.swift
//  ISH
//
//  Created by Admin on 30/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import DLRadioButton
import SVProgressHUD
import MobileCoreServices
import PlugNPlay
import PayUMoneyCoreSDK
class CheckoutTableViewController: UITableViewController {

  
    static var checkoutMethod = ""
    
    
    //private order overview Variables
    private var orderCgst = ""
    private var orderSgst = ""
    private var orderShipping = ""
    private var orderGrossTotal = ""
    private var orderTotal = ""
    
    
    private var pointstobeused = "0"
    
    private let cart = CartCountModel()
    
    var cartitems = [Cart]()
    
    private var rewardPoints = ""
    
    @IBOutlet weak var walletBalLbl: UILabel!
    @IBOutlet weak var walletBalTF: UITextField!
    
    @IBOutlet weak var button1: DLRadioButton!{
        didSet{
           button1.isMultipleSelectionEnabled = true
            button1.isSelected = true
            
        }
    }
    
    @IBAction func placeOrderBtn(_ sender: UIButton) {
        
        if CheckoutTableViewController.checkoutMethod != ""{
            SVProgressHUD.show()
            
            setPaymentMethod()
            
            //set points to be used for payment
            
            if button1.isSelected{
                if rewardPoints != "0"{
                    
                    if walletBalTF.text == ""{
                        if Float(orderTotal)! <= Float(rewardPoints)!{
                            self.pointstobeused = orderTotal
//                            placeOrder(pointsToBeUsed: orderTotal)
                        }else{
                            self.pointstobeused = rewardPoints
//                            placeOrder(pointsToBeUsed: rewardPoints)
                        }
                        
                    }else{
                        if Float(walletBalTF.text!)! <= Float(rewardPoints)!{
                            if Float(walletBalTF.text!)! <= Float(orderTotal)!{
                                self.pointstobeused = walletBalTF.text!
//                                placeOrder(pointsToBeUsed: walletBalTF.text!)
                            }else{
                                SVProgressHUD.showError(withStatus: "Please enter correct amount!")
                            }
                        }else{
                            SVProgressHUD.showError(withStatus: "You don't have sufficient balance.")
                        }
                        
                    }
                    
                }else{
                    
                    self.pointstobeused = "0"
//                    placeOrder(pointsToBeUsed: "0")
                    
                    
                }
            }else{
                self.pointstobeused = "0"
//                placeOrder(pointsToBeUsed: "0")
            }
            
        }else{
            SVProgressHUD.showError(withStatus: "Please select a valid payment method")
        }
        
        
//        
//        //
        
        
        
        
    }
    
    
    @IBAction func button1(_ sender: DLRadioButton) {
        
        print("here led")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckoutTableViewController.checkoutMethod = ""
        hideKeyboardWhenTappedAround()
        SVProgressHUD.dismiss()
        
        getRewards()
        self.tableView.register(UINib(nibName: "CartOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "cocell")
        self.tableView.register(UINib(nibName: "PriceOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "pocell")
         self.tableView.register(UINib(nibName: "UploadDocumentCell", bundle: nil), forCellReuseIdentifier: "UploadDocumentCell")
        self.tableView.register(UINib(nibName: "PayUmoneySelection", bundle: nil), forCellReuseIdentifier: "PayUmoneySelection")
        
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0: return cartitems.count
        default : return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "cocell", for: indexPath) as! CartOverviewTableViewCell
        
        cell.priceLbl.text = cartitems[indexPath.row].price
        cell.prodImg.sd_setImage(with: URL(string: cartitems[indexPath.row].image),completed: nil)
        cell.qtyLbl.text = "QTY : \(cartitems[indexPath.row].qty)"
        cell.prodName.text = cartitems[indexPath.row].name
        return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UploadDocumentCell", for: indexPath) as! UploadDocumentCell
            cell.viewController = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PayUmoneySelection", for: indexPath) as! PayUmoneySelection
            return cell
        default : let cell = tableView.dequeueReusableCell(withIdentifier: "pocell", for: indexPath) as! PriceOverviewTableViewCell
        
        cell.cgst.text = orderCgst
        cell.sgst.text = orderSgst
        cell.shipping.text = orderShipping
        cell.grossPrice.text = orderGrossTotal
        cell.total.text = orderTotal
        
        return cell
        }
        
    }
    

    private func getRewards(){
        
        if let userID = defaults.string(forKey: "userID"){
             SVProgressHUD.show()
            alamofireRequest(url: "reward_point.php", params: ["hashkey":AppDelegate.apiKey,
                "custid":userID]) { (json, data) in
                    
                    if json["success"].stringValue == "1"{
                        if let x = json["customerPoint"].arrayValue.first{
                            self.rewardPoints = x["point"].stringValue
                            self.walletBalLbl.text = "Wallet Balance : \(x["point"].stringValue)"
                            self.walletBalTF.placeholder = x["point"].stringValue
                        }
                        
                        self.getCartData()
                    }
                    
            }
        
        }
        
    }
    
    
    private func getCartData(){
        
        cart.getCartData { (shiping, cgst, sgst, gross, net, cartQnty) in
            self.orderShipping = shiping
            self.orderCgst = cgst
            self.orderSgst = sgst
            self.orderGrossTotal = gross
            self.orderTotal = net
            if Float(self.rewardPoints)! <= Float(net)!{
                self.walletBalTF.placeholder = self.rewardPoints
            }else{
                self.walletBalTF.placeholder = net
            }
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    
    private func setPaymentMethod(){
        
        print(CheckoutTableViewController.checkoutMethod)
        
        DispatchQueue.main.async {

        if let userID = defaults.string(forKey: "userID"){

            alamofireRequest(url: "paymentMethod.php", params: ["hashkey":AppDelegate.apiKey,
                "custid":userID,"action":"setpayment","method":CheckoutTableViewController.checkoutMethod]) { (json, data) in
                    if json["success"].intValue == 0{
                        SVProgressHUD.showError(withStatus: "Unable to set payment method")
                    }else if json["success"].intValue == 1{
                        if CheckoutTableViewController.checkoutMethod == "payu"{
                            self.paymentViaGateway()
                        }else if CheckoutTableViewController.checkoutMethod == "cashondelivery"{
                            self.placeOrder(pointsToBeUsed: self.pointstobeused)
                        }
                        SVProgressHUD.dismiss()
                    }
            }


        }
        }
        
    }
    
    
    private func placeOrder(pointsToBeUsed : String){
       
        print(pointsToBeUsed)
        SVProgressHUD.show()
         if let userID = defaults.string(forKey: "userID"){

            alamofireRequest(url: "placeOrder.php", params: ["hashkey":AppDelegate.apiKey,"custid":userID,"balance_used":pointsToBeUsed]) { (json, data) in

                if json["success"].intValue == 1{
                    SVProgressHUD.showSuccess(withStatus: "Order Placed Successfully")

                    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                    self.present(viewController, animated: true, completion: nil)

                }else if json["success"].intValue == 0{
                    SVProgressHUD.showError(withStatus: "Problem Placing Order")

                }

            }

        }

    }
    
    
    private func paymentViaGateway(){
        
        let amount = Int(orderTotal)! - Int(pointstobeused)!
        
        PayUServiceHelper.sharedManager().getPayment(self, "mail@mymail.com", "9910901664", "Aman", String(amount), "123", didComplete: { (dict, error) in
            if let error = error {
                print("Error")
            }else {
                self.placeOrder(pointsToBeUsed: self.pointstobeused)
                print("Sucess")
            }
        }) { (error) in
            print("Payment Process Breaked")
        }
    }
    
    
   
    
}




