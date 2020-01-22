//
//  ForgotPassViewController.swift
//  ISH
//
//  Created by ASD Informatics on 05/07/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class ForgotPassViewController: UIViewController {

    
    private var flag = false
    
    @IBAction func loginBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBAction func emailTF(_ sender: UITextField) {
        
        if sender.text != ""{
            if sender.text!.isValidEmail(){
                flag = true
            }else{
                flag = false
                sender.textColor = UIColor.flatRed
            }
        }else{
            flag = false
        }
        
        
    }
    
    
    
    @IBAction func doneBtn(_ sender: UIButton) {
        if flag{
            SVProgressHUD.show()
            alamofireRequest(url: "forgotpassword.php", params: ["hashkey":AppDelegate.apiKey,"email":emailTF.text!]) { (json, data) in
                
                if json["success"].stringValue == "1"{
                    
                    SVProgressHUD.showSuccess(withStatus: json["message"].stringValue)
                    self.emailTF.textColor = UIColor.black
                    self.emailTF.text = ""
                    
                }else{
                    
                    SVProgressHUD.showError(withStatus: "This email is not registered.")
                    
                }
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
