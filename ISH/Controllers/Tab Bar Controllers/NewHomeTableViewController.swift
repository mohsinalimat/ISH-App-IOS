//
//  NewHomeTableViewController.swift
//  ISH
//
//  Created by Admin on 17/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD
import DOFavoriteButton

class NewHomeCell : UITableViewCell{
    
    @IBOutlet weak var collectionView: UICollectionView!
}


class NewHomeTableViewController: UITableViewController {
    
    var rightButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "scell")
        self.tableView.register(UINib(nibName: "FeaturedProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "fpcell")
        self.tableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "ccell")
        self.tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "bcell")
        self.tableView.register(UINib(nibName: "NewArrivalTableViewCell", bundle: nil), forCellReuseIdentifier: "nacell")
        self.tableView.register(UINib(nibName: "FourProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "fcell")
        self.tableView.register(UINib(nibName: "LedHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "lcell")
        self.tableView.register(UINib(nibName: "SubServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "sscell")
        self.tableView.register(UINib(nibName: "ACHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "accell")
        self.tableView.register(UINib(nibName: "TrackerHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "tcell")
        self.tableView.register(UINib(nibName: "SecurityTableViewCell", bundle: nil), forCellReuseIdentifier: "sqcell")
         self.tableView.register(UINib(nibName: "Banner2TableViewCell", bundle: nil), forCellReuseIdentifier: "b2cell")
        
    }

    override func viewDidAppear(_ animated: Bool) {
        getBadgeValues()
        
        var image = UIImageView(image: UIImage(named: "Navbar-Title-Logo"))
        image.contentMode = .scaleAspectFit
        self.navigationController?.navigationBar.topItem?.titleView =  image
        self.navigationController?.navigationBar.topItem?.title = "HOME"

        if defaults.string(forKey: "userID") != nil
        {
            rightButtonItem = UIBarButtonItem(image: UIImage.init(named: "Navigationbar-logout-rounded-up-72"), style:.plain, target: self, action: #selector(self.rightButtonTapped))
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButtonItem
            
        }
    }
    
    
    
    @objc private func rightButtonTapped(){
        defaults.removeObject(forKey: "userName")
        defaults.removeObject(forKey: "userID")
        defaults.removeObject(forKey: "userEmail")
        defaults.removeObject(forKey: "skipSignIn")
        if let next  = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC"){
            self.present(next, animated: true, completion: nil)
            
        }
    }
    
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
            
        case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "sscell", for: indexPath) as! SubServicesTableViewCell
        
        
        cell.viewController = self
        
        if cell.flag == true{
        cell.awakeFromNib()
        }
        return cell
            
            
        
//        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "ccell", for: indexPath) as! CategoriesTableViewCell
//
//        cell.viewController = self
//
//        return cell
        
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as! SliderTableViewCell
        
        if cell.flag == true{
            cell.awakeFromNib()
        }
        
        return cell
            
            
        case 2 : let cell = tableView.dequeueReusableCell(withIdentifier: "accell", for: indexPath) as! ACHomeTableViewCell
        
        cell.url = "ac_home_products.php"
        cell.viewController = self
        cell.productsTitle = "AC"
        
        if cell.flag == true{
            cell.printURL()
        }
        
        
        return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: "fpcell", for: indexPath) as! FeaturedProductsTableViewCell
        
        
        cell.viewController = self
        if cell.flag == true{
            cell.awakeFromNib()
        }
        return cell
            
        case 4 : let cell = tableView.dequeueReusableCell(withIdentifier: "b2cell", for: indexPath) as! Banner2TableViewCell
        cell.awakeFromNib()
        return cell
        
        case 5 : let cell = tableView.dequeueReusableCell(withIdentifier: "lcell", for: indexPath) as! LedHomeTableViewCell
        
        cell.url = "led_home_products.php"
        cell.viewController = self
        cell.productsTitle = "LED"
        if cell.flag == true{
            cell.printURL()
        }
        
        return cell
            
            
            
        case 7 : let cell = tableView.dequeueReusableCell(withIdentifier: "bcell", for: indexPath) as! BannerTableViewCell
        if cell.flag == true{
            cell.awakeFromNib()
        }
            return cell
            
        case 6 : let cell = tableView.dequeueReusableCell(withIdentifier: "sqcell", for: indexPath) as! SecurityTableViewCell
        
        cell.url = "security_shutter_home_products.php"
        cell.viewController = self
        cell.productsTitle = "Security"
        if cell.flag == true{
            cell.printURL()
        }
        
        return cell
            
        case 8 : let cell = tableView.dequeueReusableCell(withIdentifier: "nacell", for: indexPath) as! NewArrivalTableViewCell
        
            cell.viewController = self
        if cell.flag == true{
            cell.awakeFromNib()
        }
        
            return cell
            
            
        case 9 : let cell = tableView.dequeueReusableCell(withIdentifier: "fcell", for: indexPath) as! FourProductsTableViewCell
        
        cell.url = "hologram_home_products.php"
        cell.viewController = self
        cell.productsTitle = "Holograms"
        if cell.flag == true{
            cell.printURL()
        }
        
        return cell
            
        
        default : let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as! TrackerHomeTableViewCell
        
        cell.url = "raahi_home_products.php"
        cell.viewController = self
        cell.productsTitle = "Trackers"
        if cell.flag == true{
            cell.printURL()
        }
        
        return cell
            
        }
        
        
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0 : return 330
            case 1,7,4 : return 200
//            case 1: return 147
            case 2,5,6,9,10 : return 363
            case 3 : return 1600
            case 8: return 950
            default : return 0
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0 : return ""
//      case 1 : return "Categories"
        case 1 : return "Offers"
        case 2 : return "AC"
        case 3 : return "Featured Products"
        case 4 : return "Offers"
        case 5 : return "LED"
        case 7: return "Services"
        case 6 : return "Security"
        case 8 : return "New Arrivals"
        case 9 : return "Hologram"
        default : return "Trackers"
            
        }
    }
    
    
}




    

