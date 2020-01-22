//
//  CategoriesTableViewCell.swift
//  ISH
//
//  Created by Admin on 22/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD

class CategoriesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var viewController : UIViewController? = nil

    
    var flag = true
    
    private struct OurServices{
        var img : String
        var title : String
        var id : String
    }
    
    
    private var ourServices = [OurServices]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let blueprintLayout = HorizontalBlueprintLayout(
            itemsPerRow: 3.0,
            itemsPerColumn: 1,
            height: 160,
            minimumInteritemSpacing: 0,
            minimumLineSpacing: 0,
            sectionInset: EdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            stickyHeaders: true,
            stickyFooters: true
        )
        
        collectionView.collectionViewLayout = blueprintLayout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib(nibName: "OurServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "oscell")
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        getOurServices()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getOurServices(){
        alamofireRequest(url: "ourservices.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
            
            do{
                
                self.ourServices = [OurServices]()
                let slider = try JSONDecoder().decode(OurServicesRoot.self, from: data)
                
                if slider.success == "1"{
                    self.flag = false
                    
                    for x in slider.category{
                        self.ourServices.append(OurServices(img: x.img, title: x.name, id: x.id))
                    }
                }else{
                    SVProgressHUD.showError(withStatus: slider.message)
                }
                //                SVProgressHUD.dismiss()
//                self.getHomeData()
                self.collectionView.reloadData()
            }catch{
                print(error)
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ourServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oscell", for: indexPath) as! OurServicesCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: ourServices[indexPath.row].img), completed: nil)
        cell.titleLbl.text = ourServices[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print(ourServices[indexPath.row].id)
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesVC") as! ServiceProductViewController
        
        
        if let navigator = self.viewController?.navigationController {
            viewController.productid = ourServices[indexPath.row].id
            viewController.homeTitle = ourServices[indexPath.row].title
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
    
    
    
}
