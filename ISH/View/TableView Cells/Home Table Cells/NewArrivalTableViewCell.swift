//
//  NewArrivalTableViewCell.swift
//  ISH
//
//  Created by Admin on 22/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD

class NewArrivalTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var flag = true
    
    private struct NewArrival{
        var prodID : String
        var img : String
        var prodName : String
        var prodPrice : String
        var wishlist : String
        var prodSku : String
    }

    
    var viewController : UIViewController? = nil
    
    private var newArrival = [NewArrival]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 2.0,
            height: 300,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        collectionView.collectionViewLayout = blueprintLayout
        collectionView.isScrollEnabled = false
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pcell")
        
        //        cell.collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        getNewArrivals()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newArrival.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        //        print("new arrivals\(newArrivals[indexPath.row].img)")
        
        cell.imgView.sd_setImage(with: URL(string: newArrival[indexPath.row].img), completed: nil)
        cell.price.text = "₹"+newArrival[indexPath.row].prodPrice
        cell.productName.text = newArrival[indexPath.row].prodName
        
        return cell
    }
    
    private func getNewArrivals(){
    
        
            alamofireRequest(url: "newarrival_home.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
                do{
                    self.newArrival = [NewArrival]()
                    
                    let arrival = try JSONDecoder().decode(NewArrivalsRoot.self, from: data)
                    
                    if arrival.success == "1"{
                        self.flag = false
                        for x in arrival.todayDeals{
                            
                            self.newArrival.append(NewArrival(prodID: x.id, img: x.img, prodName: x.name, prodPrice: String(x.price), wishlist: x.wishlist, prodSku: x.sku))
                            
                            
                        }
                        
                    }else if arrival.success == "0" {
                        SVProgressHUD.showError(withStatus : arrival.message)
                    }
                    
                    SVProgressHUD.dismiss()
                   self.collectionView.reloadData()
                    
                }catch{
                    
                    print(error)
                }
            }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = self.viewController?.navigationController {
            viewController.prodid = newArrival[indexPath.row].prodID
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
}
    

