//
//  NavigateToVCModel.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController{
    
    func goToPage(goto : String){
        
        
        switch goto{
        case "My Cart":
       segue(storyboard: "Main", goTo: goto)
        case "My Wishlist":
        self.tabBarController!.selectedIndex = 2
        case "Home":
            self.tabBarController!.selectedIndex = 0
        case "Services":
            segue(storyboard: "Main", goTo: goto)
        case "My Wallet":
            segue(storyboard: "Account", goTo: goto)
        case "My Orders":
            segue(storyboard: "Account", goTo: goto)
        case "Address" : 
            segue(storyboard: "Checkout", goTo: goto)
        case "Login" :
            segue(storyboard: "Main", goTo: goto)
        
        case "Checkout" :
            segue(storyboard: "Checkout", goTo: goto)
            
            
        default:
            SVProgressHUD.showInfo(withStatus: "Sorry, This feature isn't available yet.")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
    
    
    private func segue(storyboard: String, goTo:String){
        // Safe Push VC
        let viewController = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: goTo+"VC")
        if let navigator = navigationController {
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
        
        
    }
    
    
    
}

