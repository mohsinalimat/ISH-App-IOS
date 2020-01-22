//
//  LoginViewController.swift
//  ISH
//
//  Created by Admin on 10/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD


class LoginViewController: UIViewController {
    
    private var passView = false
    
    var flag = ""
    
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameTF: UITextField!
    @IBAction func registrationBtn(_ sender: UIButton) {
        
        
        
        
    }
    
    
    @IBOutlet weak var skipSignInBtn: UIButton!
    @IBAction func skipSignInBtn(_ sender: UIButton) {
        
        defaults.set("1",forKey: "skipSignIn")
        
         let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var passTF: UITextField!{
        didSet{
            passwordImage(icon: UIImage(named: "Login-PassHide-icon")!)
           
        }
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        
        if usernameTF.text != "" && passTF.text != ""{
            SVProgressHUD.show()
            
            alamofireRequest(url: "customerLogin.php", params: ["hashkey":AppDelegate.apiKey, "email":usernameTF.text!,"pwd" : passTF.text! ]) { (json, data) in
                
                do{
                    if json["success"].intValue == 1{
                        SVProgressHUD.showSuccess(withStatus: json["message"].stringValue)
                        
                        defaults.set("\(json["firstname"].stringValue) \(json["lastname"].stringValue)", forKey: "userName")
                        
                        defaults.set(json["customerId"].stringValue, forKey: "userID")
                        
                        defaults.set(json["email"].stringValue, forKey: "userEmail")
                        
                        if self.flag == "cart"{
                            self.performSegue(withIdentifier: "goBack", sender: self)
                        }else if self.flag == "account"{
                            self.performSegue(withIdentifier: "goBackToAccount", sender: self)
                        }else{
                            if let next  = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC"){
                                self.present(next, animated: true, completion: nil)
                            }
                        }
                        
                    }else{
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                        
                        self.usernameTF.text = ""
                        self.passTF.text = ""
                    }
                }catch{
                    print(error)
                }
                
            }
            
            
            
            
        }else{
            if usernameTF.text == ""{
                SVProgressHUD.showInfo(withStatus: "Username can't be empty.")
            }else if passTF.text == ""{
                SVProgressHUD.showInfo(withStatus: "Password can't be empty.")
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if flag != ""{
            skipSignInBtn.isHidden = true
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    
    
    
    private func passwordImage(icon : UIImage){
        
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((passTF.frame.height) * 0.70), height: ((passTF.frame.height) * 0.70)))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        btnView.addTarget(self, action: #selector(tfPassHiddenVisible), for: .touchUpInside)
        passTF.rightViewMode = .always
        passTF.rightView = btnView
        
        
    }
    
    
    @objc private func tfPassHiddenVisible(){
        passView = !passView
        
        if passView{
            passwordImage(icon: UIImage(named: "Login-PassView-icon")!)
            passTF.isSecureTextEntry = false
        }else{
            passwordImage(icon: UIImage(named: "Login-PassHide-icon")!)
            passTF.isSecureTextEntry = true
        }
        
        
        
    }
    
}
