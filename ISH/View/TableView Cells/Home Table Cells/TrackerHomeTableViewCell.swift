//
//  TrackerHomeTableViewCell.swift
//  ISH
//
//  Created by Admin on 03/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class TrackerHomeTableViewCell: UITableViewCell {

    var url = ""
    var productsTitle = ""
    
    var flag = true
    
    
    var viewController : UIViewController?
    
    private struct Product{
        var prodID : String
        var img : String
        var prodName : String
        var prodPrice : String
        var wishlist : String
        var prodSku : String
    }
    
    private var prods = [Product]()
    private var categoryID = ""
    
    @IBAction func viewAllBtn(_ sender: UIButton) {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesVC") as! ServiceProductViewController
        
        
        if let navigator = self.viewController?.navigationController {
            viewController.productid = categoryID
            viewController.homeTitle = productsTitle
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
        
        
    }
    
    @IBOutlet weak var itemOne: UIButton!{
        didSet{
            itemOne.setImage(nil, for: .normal)
        }
    }
    @IBOutlet weak var itemOneTxt: UILabel!
    @IBAction func itemOne(_ sender: UIButton) {
        goToProductDetailsPage(position: 0)
    }
    
    
    @IBOutlet weak var itemTwo: UIButton!{
        didSet{
            itemTwo.setImage(nil, for: .normal)
        }
    }
    @IBOutlet weak var itemTwoTxt: UILabel!
    @IBAction func itemTwo(_ sender: UIButton) {
        goToProductDetailsPage(position: 1)
    }
    
    @IBOutlet weak var itemThree: UIButton!{
        didSet{
            itemThree.setImage(nil, for: .normal)
        }
    }
    @IBOutlet weak var itemThreeTxt: UILabel!
    @IBAction func itemThree(_ sender: UIButton) {
        goToProductDetailsPage(position: 2)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func printURL(){
       
            
            alamofireRequest(url: url, params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
                do{
                    self.prods = [Product]()
                    
                    let home = try JSONDecoder().decode(HomeProductsRoot.self, from: data)
                    
                    if home.success == "1"{
                        
                        self.flag = false
                        
                        for x in home.categoryProduct{
                            
                            self.prods.append(Product(prodID: x.id, img: x.img, prodName: x.name, prodPrice: String(x.price), wishlist: x.wishlist, prodSku: x.sku))
                            
                            
                        }
                        
                    }else if home.success == "0" {
                        SVProgressHUD.showError(withStatus : home.message)
                    }
                    
                    self.itemOneTxt.text = self.prods[0].prodName
                    self.itemTwoTxt.text = self.prods[1].prodName
                    self.itemThreeTxt.text = self.prods[2].prodName
                    
                    
                    alamofireImageRequest(url: self.prods[0].img, completion: { (img) in
                        self.itemOne.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
                    })
                    
                    alamofireImageRequest(url: self.prods[1].img, completion: { (img) in
                        self.itemTwo.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
                    })
                    
                    alamofireImageRequest(url: self.prods[2].img, completion: { (img) in
                        self.itemThree.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
                    })
                    
                    
                    self.categoryID = home.cateid
                    SVProgressHUD.dismiss()
                    
                }catch{
                    
                    print(error)
                }
            
        }
    }
    
    
    private func goToProductDetailsPage(position : Int){
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = self.viewController?.navigationController {
            viewController.prodid = prods[position].prodID
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
        
        
    }
    
}
