//
//  AddAddressViewController.swift
//  ISH
//
//  Created by Admin on 29/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddAddressViewController: UIViewController {

    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var street: UITextField!
    
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var telephone: UITextField!
    
    @IBAction func addAddressBtn(_ sender: UIButton) {
        
        if firstName.text != "" && lastName.text != "" && street.text != "" && city.text != "" && state.text != "" && postalCode.text != "" && country.text != "" && telephone.text != ""{
            
            self.addAddress()
            
            
            
        }else{
            if firstName.text == ""{
                SVProgressHUD.showInfo(withStatus: "First Name can't be empty!")
            }else if lastName.text == ""{
                SVProgressHUD.showInfo(withStatus: "Last Name can't be empty!")
            }else if street.text == "" {
                SVProgressHUD.showInfo(withStatus: "Street Name can't be empty!")
            }else if  city.text == "" {
                SVProgressHUD.showInfo(withStatus: "City Name can't be empty!")
            }else if  state.text == "" {
                SVProgressHUD.showInfo(withStatus: "State Name can't be empty!")
            }else if  postalCode.text == "" {
                SVProgressHUD.showInfo(withStatus: "Postal Code can't be empty!")
            }else if  country.text == ""{
                SVProgressHUD.showInfo(withStatus: "Country Name can't be empty!")
            }else if telephone.text == ""{
                SVProgressHUD.showInfo(withStatus: "Telephone can't be empty!")
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    
    
    private func addAddress(){
        
        if let userID = defaults.string(forKey: "userID"){
            SVProgressHUD.show()
            alamofireRequest(url: "cutomerAddressCreate.php", params: ["hashkey":AppDelegate.apiKey,
                "custid":userID,
                "firstname":firstName.text!,
                "lastname":lastName.text!,
                "street":street.text!,
                "streetone":street.text!,
                "city":city.text!,
                "region":state.text!,
                "postcode":postalCode.text!,
                "country_id":country.text!,
                "telephone":telephone.text!,
                "defaultbill":"true",
                "defaultship":"true"]) { (json, data) in
                    
                    if json["success"].intValue == 1{
                         self.performSegue(withIdentifier: "unwind", sender: self)
                    }else{
                        SVProgressHUD.showError(withStatus: "Unable to save Address!")
                    }
            }
        
        }
    }


}
