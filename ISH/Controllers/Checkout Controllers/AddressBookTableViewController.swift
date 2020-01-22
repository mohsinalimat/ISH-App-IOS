//
//  AddressBookTableViewController.swift
//  ISH
//
//  Created by Admin on 29/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddressBookTableViewController: UITableViewController {

    
    var cartItems = [Cart]()
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        getAddresses()
        
    }
    
    private struct Address{
        var id, firstname, lastname, street, city, region, postcode, countryID, telephone: String
        var defaultbilling, defaulshiping: Bool
        
    }
    
    private var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        SVProgressHUD.dismiss()
        self.tableView.register(UINib(nibName: "AddNewAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "anacell")
        self.tableView.register(UINib(nibName: "AddressesTableViewCell", bundle: nil), forCellReuseIdentifier: "acell")
        
       getAddresses()
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 1 : return addresses.count
        default : return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 1 : let cell = tableView.dequeueReusableCell(withIdentifier: "acell", for:  indexPath) as! AddressesTableViewCell
            cell.addressLbl.text = "\(addresses[indexPath.row].street),\n\(addresses[indexPath.row].region),\n\(addresses[indexPath.row].city) - \(addresses[indexPath.row].postcode)\n\(addresses[indexPath.row].countryID)"
        
        cell.mobileNoLbl.text = addresses[indexPath.row].telephone
        cell.nameLbl.text = "\(addresses[indexPath.row].firstname) \(addresses[indexPath.row].lastname)"
        
        cell.deleteBtn.tag = indexPath.row
        
        cell.deleteBtn.addTarget(self, action: #selector(self.removeFromAddressBook(_:)), for: .touchUpInside)
        
            return cell
            
        default : let cell = tableView.dequeueReusableCell(withIdentifier: "anacell", for:  indexPath) as! AddNewAddressTableViewCell
        
        return cell
        }
        
    }

    private func getAddresses(){
        
        if let userID = defaults.string(forKey: "userID"){
            SVProgressHUD.show()
            alamofireRequest(url: "cutomerAddress.php", params: ["hashkey":AppDelegate.apiKey, "custid":userID]) { (json, data) in
                
                do{
                    
                    self.addresses = [Address]()
                    let add = try JSONDecoder().decode(AddressRoot.self, from: data)
                    
                    if add.success == 1{
                        for x in add.customerAddress{
                            self.addresses.append(Address(id: String(x.id), firstname: x.firstname, lastname: x.lastname, street: x.street, city: x.city, region: x.region, postcode: x.postcode, countryID: "IN", telephone: x.telephone, defaultbilling: x.defaultbilling, defaulshiping: x.defaultbilling))
                        }
                    }else{
                        SVProgressHUD.showError(withStatus: add.message)
                    }
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
                
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Select Shipping Address"
        default:
            return " "
        }
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0 : self.performSegue(withIdentifier: "goToAdd", sender: self)
        default: setShippingAddress(address: addresses[indexPath.row])
        }
    }
    
    
    
    @objc private func removeFromAddressBook(_ sender: UIButton){
        SVProgressHUD.show()
       
            
            alamofireRequest(url: "cutomerAddressDelete.php", params: ["hashkey":AppDelegate.apiKey, "id" : addresses[sender.tag].id]) { (json, data) in
                
                if json["success"].stringValue == "1"{
                    self.getAddresses()
                }
                
            }
        
    }
    
    
    
    private func setShippingAddress(address : Address){
        setShippingMethod()
        
       SVProgressHUD.show()
        
//        goToPage(goto: "Checkout")
        
        if let userID = defaults.string(forKey: "userID"){

            alamofireRequest(url: "checkOut.php", params: ["hashkey":AppDelegate.apiKey,"custid":userID,"action":"setaddress","bill_firstname":address.firstname,"bill_lastname":address.lastname,"bill_street":address.street,"bill_city":address.city,"bill_region":address.region,"bill_postcode":address.postcode,"bill_country_id":address.countryID,"bill_telephone":address.telephone]) { (json, data) in


                if json["success"].stringValue == "1"{
                    SVProgressHUD.dismiss()
                    // Safe Push VC
                    let viewController = UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutTableViewController
                    if let navigator = self.navigationController {
                        viewController.cartitems = self.cartItems
                        navigator.pushViewController(viewController, animated: true)
                    }else{
                        print("unable to navigate")
                    }


                }else if json["success"].stringValue == "0"{
                    SVProgressHUD.showError(withStatus: "Unable to set address")
                }

            }


        }

     }
    
    
    private func setShippingMethod(){
        DispatchQueue.main.async {
            if let userID = defaults.string(forKey: "userID"){
                
                alamofireRequest(url: "shipingmethod.php", params:["hashkey":AppDelegate.apiKey,
                    "custid":userID,
                    "action":"setshiping",
                    "code":"freeshipping_freeshipping"], completion: { (json, data) in
                        
                        if json["success"].intValue == 0{
                            SVProgressHUD.showError(withStatus: json["message"].stringValue)
                        }
                        
                        
                })
            }
        }
    }
    
}

