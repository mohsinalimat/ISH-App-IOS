//
//  FeaturedProductsTableViewCell.swift
//  ISH
//
//  Created by Admin on 22/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD

class FeaturedProductsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var flag = true

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewController : UIViewController? = nil
    
    
    private struct FeaturedProducts{
        var prodID : String
        var img : String
        var prodName : String
        var prodPrice : String
        var wishlist : String
        var prodSku : String
    }
    
    private var featuredProducts = [FeaturedProducts]()
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getProductsData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    private func getProductsData(){
        
       
            
            alamofireRequest(url: "featured_product_home.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
                do{
                    
                    self.featuredProducts = [FeaturedProducts]()
                    
                    let featured = try JSONDecoder().decode(HomeFeaturedRoot.self, from: data)
                    
                    if featured.success == "1"{
                        
                        self.flag = false
                        for x in featured.featuredProduct{
                            
                            self.featuredProducts.append(FeaturedProducts(prodID: x.id, img: x.img, prodName: x.name, prodPrice: String(x.price), wishlist: x.wishlist, prodSku: x.sku))
                            
                        }
                    }else if featured.success == "0"{
                        SVProgressHUD.showError(withStatus: featured.message)
                    }
                    
                    SVProgressHUD.dismiss()
                    self.collectionView.reloadData()
                    
                }catch{
                    print(error)
                }
            }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: featuredProducts[indexPath.row].img), completed: nil)
        cell.price.text = "₹"+featuredProducts[indexPath.row].prodPrice
        cell.productName.text = featuredProducts[indexPath.row].prodName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = self.viewController?.navigationController {
            viewController.prodid = featuredProducts[indexPath.row].prodID
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
    
}
