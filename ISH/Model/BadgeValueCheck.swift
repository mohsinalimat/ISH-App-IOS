//
//  BadgeValueCheck.swift
//  ISH
//
//  Created by Admin on 12/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

extension UIViewController{
    
    
    func getBadgeValues(){
        
        if defaults.object(forKey: "userID") != nil{
            if let userid = defaults.string(forKey: "userID"){
                alamofireRequest(url: "count.php", params: ["hashkey":AppDelegate.apiKey, "custid":userid ]) { (json, data) in
                    
                    if json["success"].intValue == 1{
                        
                        if let tabItems = self.tabBarController?.tabBar.items {
                            
                            if json["Wishlist Count"].intValue != 0{
                                tabItems[2].badgeValue = String(json["Wishlist Count"].intValue)
                            }else{
                                tabItems[2].badgeValue = nil
                            }
                            
                            if json["TotalQty"].intValue != 0{
                                tabItems[3].badgeValue = String(json["TotalQty"].intValue)
                            }else{
                                tabItems[3].badgeValue = nil
                            }
                            
                            
                        }
                        
                    }else {
                        if let tabItems = self.tabBarController?.tabBar.items {
                            
                            tabItems[2].badgeValue = nil
                            tabItems[3].badgeValue = nil
                            
                        }
                    }
                    
                }
            }
        }else{
            
            createRealmObj { (realm) in
                let cart = realm.objects(CartRealm.self)
                if cart.count != 0{
                    var count = 0
                    
                    for x in cart {
                        count = count + Int(x.qty)!
                    }
                    
                    if let tabItems = self.tabBarController?.tabBar.items {
                        
                        tabItems[2].badgeValue = nil
                        tabItems[3].badgeValue = String(count)
                        
                    }
                }else{
                    if let tabItems = self.tabBarController?.tabBar.items {
                        
                        tabItems[2].badgeValue = nil
                        tabItems[3].badgeValue = nil
                        
                    }
                }
            }
        }
        
    }
}


