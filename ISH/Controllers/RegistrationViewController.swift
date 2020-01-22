//
//  RegistrationViewController.swift
//  ISH
//
//  Created by Admin on 10/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegistrationViewController: UIViewController {

    @IBAction func goToLoginBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func registerBtn(_ sender: UIButton) {
        SVProgressHUD.show()
        
        if firstName.text != "" && lastName.text != "" && email.text != "" && mobileNo.text != "" && password.text != "" && confirmPassword.text != ""{
            
            if password.text == confirmPassword.text{
                if password.text!.count >= 6{
                    alamofireRequest(url: "custmerregister.php", params: [ "hashkey": AppDelegate.apiKey, "email" : email.text!, "fname" : firstName.text!, "lname" : lastName.text!, "pwd" : password.text!, "mobile" : mobileNo.text!]) { (json, data) in
                    
                    if json["success"].stringValue == "1"{
                        SVProgressHUD.showSuccess(withStatus: "Registration Successful! \n Please visit the link sent to your email to activate your account")
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }else if json["success"].stringValue == "0"{
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    }
                                                            
                                                            
                }
                }else{
                    SVProgressHUD.showError(withStatus: "Password must contain 6 characters")
                }
                
            }else{
                SVProgressHUD.showInfo(withStatus: "Password doesn't match!")
            }
            
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    
}
