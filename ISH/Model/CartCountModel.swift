//
//  CartCountModel.swift
//  ISH
//
//  Created by Admin on 31/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import Foundation


class CartCountModel{

    func getCartData(completion : @escaping (String, String, String, String, String, String) -> Void){
        
        if let userID = defaults.string(forKey: "userID"){
            alamofireRequest(url: "count.php", params: ["hashkey":AppDelegate.apiKey, "custid":userID ]) { (json, data) in
                
                if json["success"].stringValue == "1"{
                    
                    
                    completion(String(json["Shipping"].intValue),
                               String(json["CGST"].doubleValue),
                               String(json["SGST"].doubleValue),
                               String(json["Total Amount"].intValue),
                               String(json["Grand Total"].intValue),
                               String(json["TotalQty"].intValue))
                    
                }
                
            }
        }
        
    }
    
    
}
