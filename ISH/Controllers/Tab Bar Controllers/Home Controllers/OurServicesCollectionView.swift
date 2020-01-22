//
//  OurServicesCollectionView.swift
//  ISH
//
//  Created by Admin on 15/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD


class OurServiceCell : UICollectionViewCell{
    
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.changeToCircularImageView()
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    
}



class OurServicesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    // variables
    private var img = [String]()
    private var title = [String]()
    private var id = [String]()
    
    
    
    override func awakeFromNib() {
       
        
        
        
        self.delegate = self
        self.dataSource = self
        
        let blueprintLayout = HorizontalBlueprintLayout(
            itemsPerRow: 3.0,
            itemsPerColumn: 1,
            height: 150,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        self.collectionViewLayout = blueprintLayout
        
        
        self.register(UINib(nibName: "OurServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "osell")
        
        SVProgressHUD.show()
        getOurServices()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return id.count ?? 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oscell", for: indexPath) as! OurServicesCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: img[indexPath.row]), completed: nil)
        cell.titleLbl.text = title[indexPath.row]
        
        return cell
    }
    

    private func getOurServices(){
        alamofireRequest(url: "ourservices.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
            
            do{
                let slider = try JSONDecoder().decode(OurServicesRoot.self, from: data)
                
                if slider.success == "1"{
                    for x in slider.category{
                        self.id.append(x.id)
                        self.title.append(x.name)
                        self.img.append(x.img)
                    }
                }else{
                    SVProgressHUD.showError(withStatus: slider.message)
                }
                SVProgressHUD.dismiss()
                self.reloadData()
            }catch{
                print(error)
            }
            
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        
//        let vc =  HomeViewController()
//        
//        vc.goToServices()
        

    }
    
    
    
    
}

