//
//  CartRealmModel.swift
//  ISH
//
//  Created by Admin on 10/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import Foundation
import RealmSwift


class CartRealm : Object{
    
    @objc dynamic var id = ""
//    @objc dynamic var item_id = ""
    @objc dynamic var name = ""
    @objc dynamic var cart = ""
    @objc dynamic var sku = ""
    @objc dynamic var qty = ""
    @objc dynamic var price = ""
    @objc dynamic var regularPrice = ""
    @objc dynamic var image = ""
    
}

func createRealmObj(completion : @escaping (Realm)->Void){
    
    do{
        let realm = try Realm()
        completion(realm)
    }catch{
        print("Realm Error : \(error)")
    }
    
    
    
}

