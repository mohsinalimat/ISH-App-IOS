//
//  SubServicesTableViewCell.swift
//  ISH
//
//  Created by Admin on 28/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD
import SDWebImage

class SubServicesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var flag = true
    
    
    var viewController : UIViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private struct SubService{
        var id : String
        var img : String
        var name : String
        var url : String
    }
    
    private var subservices = [SubService]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 70,
            minimumInteritemSpacing: 5,
            minimumLineSpacing: 5,
            sectionInset: EdgeInsets(top: 5, left: 5, bottom: 5, right: 5),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        collectionView.collectionViewLayout = blueprintLayout
        
        collectionView.isScrollEnabled = false
        collectionView.register(UINib(nibName: "SubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sscell")
        
        
        
        getSubServiceData()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func getSubServiceData(){
        
        alamofireRequest(url: "services.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
            do{
                
                self.subservices = [SubService]()
                //SubServicesRoot.self
                let ss = try JSONDecoder().decode(HomeServicesRoot.self, from: data)
                
                if ss.success == "1"{
                    
                    self.flag = false
                    for x in ss.category{
                        
                        self.subservices.append(SubService(id: x.id, img: x.img ?? "", name: x.name, url: x.url ?? ""))
                        
                    }
                }else if ss.success == "0"{
                    SVProgressHUD.showError(withStatus: "Problem while loading data")
                    
                }
                
                SVProgressHUD.dismiss()
                
                
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                
            }catch{
                print(error)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subservices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sscell", for: indexPath) as! SubServicesCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string: subservices[indexPath.row].img), completed: nil)
        cell.titleLbl.text = subservices[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if subservices[indexPath.row].id == "0"{
            
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubServicesVC")
            
            if let navigator = self.viewController?.navigationController {
//                viewController.productid = subservices[indexPath.row].id
//                viewController.homeTitle = subservices[indexPath.row].name
                navigator.pushViewController(viewController, animated: true)
            }else{
                print("unable to navigate")
            }
            
            
        }else{
            
            if subservices[indexPath.row].url == ""{
                
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesVC") as! ServiceProductViewController
                
                if let navigator = self.viewController?.navigationController {
                    viewController.productid = subservices[indexPath.row].id
                    viewController.homeTitle = subservices[indexPath.row].name
                    navigator.pushViewController(viewController, animated: true)
                }else{
                    print("unable to navigate")
                }
            }else{
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as! LoadSubviewInURLViewController
                
                
                if let navigator = self.viewController?.navigationController {
                    viewController.weburl = subservices[indexPath.row].url
                    viewController.homeTitle = subservices[indexPath.row].name
                    navigator.pushViewController(viewController, animated: true)
                }else{
                    print("unable to navigate")
                }
            }
        }
        
        
    }
    
    
    
}

