//
//  SubServicesTableViewController.swift
//  ISH
//
//  Created by Admin on 01/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD




class SubServicesTableViewController: UITableViewController {

    
    private struct SubService{
        
        var id, name: String
        var img: String
        var categoryid: String
        var categoryname: String
        var url: String
        
        
    }
    
    private var ffsubservice = [SubService]()
    private var cgsubservice = [SubService]()
    private var edusubservice = [SubService]()
    private var sssubservice = [SubService]()
    private var msubservice = [SubService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
    
        self.tableView.register(UINib(nibName: "FFTableViewCell", bundle: nil), forCellReuseIdentifier: "ffcell")
        self.tableView.register(UINib(nibName: "CGTableViewCell", bundle: nil), forCellReuseIdentifier: "cgcell")
        self.tableView.register(UINib(nibName: "EDUTableViewCell", bundle: nil), forCellReuseIdentifier: "educell")
        self.tableView.register(UINib(nibName: "SSTableViewCell", bundle: nil), forCellReuseIdentifier: "sscell")
        self.tableView.register(UINib(nibName: "MTableViewCell", bundle: nil), forCellReuseIdentifier: "mcell")
        
        
        
        
        getSubServices()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 :  let cell = tableView.dequeueReusableCell(withIdentifier: "ffcell", for: indexPath) as! FFTableViewCell
        
        cell.collectionView.tag = indexPath.section
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 100,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        cell.collectionView.collectionViewLayout = blueprintLayout
        
        cell.collectionView.isScrollEnabled = false
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(UINib(nibName: "HomeSubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hsscell")
        return cell
            
        case 1:  let cell = tableView.dequeueReusableCell(withIdentifier: "cgcell", for: indexPath) as! CGTableViewCell
        
        cell.collectionView.tag = indexPath.section
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 100,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        cell.collectionView.collectionViewLayout = blueprintLayout
        
        cell.collectionView.isScrollEnabled = false
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(UINib(nibName: "HomeSubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hsscell")
        return cell
            
        case 2:  let cell = tableView.dequeueReusableCell(withIdentifier: "educell", for: indexPath) as! EDUTableViewCell
        
        cell.collectionView.tag = indexPath.section
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 100,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        cell.collectionView.collectionViewLayout = blueprintLayout
        
        cell.collectionView.isScrollEnabled = false
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(UINib(nibName: "HomeSubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hsscell")
        return cell
            
        case 3:  let cell = tableView.dequeueReusableCell(withIdentifier: "sscell", for: indexPath) as! SSTableViewCell
        
        cell.collectionView.tag = indexPath.section
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 100,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        cell.collectionView.collectionViewLayout = blueprintLayout
        
        cell.collectionView.isScrollEnabled = false
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(UINib(nibName: "HomeSubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hsscell")
        return cell
            
        default:  let cell = tableView.dequeueReusableCell(withIdentifier: "mcell", for: indexPath) as! MTableViewCell
        
        cell.collectionView.tag = indexPath.section
        
        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 3.0,
            height: 100,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        
        cell.collectionView.collectionViewLayout = blueprintLayout
        
        cell.collectionView.isScrollEnabled = false
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(UINib(nibName: "HomeSubServicesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hsscell")
        return cell
            
            
        }
        
       
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0 : return 250
        case 1 : return 250
        case 2 : return 150
        case 3 : return 390
        case 4 : return 250
        default : return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0 : return "Financial Flux"
         case 1 : return "Creative Gallery"
            case 2 : return "EDU Basket"
            case 3 : return "Smart Serve"
            case 4 : return "Mall"
        default : return ""
        }
    }
    
    
    
    private func getSubServices(){
        
         SVProgressHUD.show()
        alamofireRequest(url: "subservices.php", params: ["hashkey" : AppDelegate.apiKey]) { (json, data) in
            
            do{
                
                self.ffsubservice = [SubService]()
                self.cgsubservice = [SubService]()
                self.edusubservice = [SubService]()
                self.sssubservice = [SubService]()
                self.msubservice = [SubService]()
                
               let subService = try JSONDecoder().decode(HomeSubServicesRoot.self, from: data)
                
                if subService.success == "1"{
                    
                    for x in subService.category{
                        
                        if x.categoryid == 78{
                            self.edusubservice.append(SubService(id: x.id, name: x.name, img: x.img, categoryid: String(x.categoryid), categoryname: x.categoryname, url: x.url))
                        }else if x.categoryid == 49{
                            self.ffsubservice.append(SubService(id: x.id, name: x.name, img: x.img, categoryid: String(x.categoryid), categoryname: x.categoryname, url: x.url))
                        }else if x.categoryid == 50{
                            self.cgsubservice.append(SubService(id: x.id, name: x.name, img: x.img, categoryid: String(x.categoryid), categoryname: x.categoryname, url: x.url))
                        }else if x.categoryid == 79{
                             self.sssubservice.append(SubService(id: x.id, name: x.name, img: x.img, categoryid: String(x.categoryid), categoryname: x.categoryname, url: x.url))
                        }else if x.categoryid == 430{
                            self.msubservice.append(SubService(id: x.id, name: x.name, img: x.img, categoryid: String(x.categoryid), categoryname: x.categoryname, url: x.url))
                        }
                        
                        
                    }
                }else if subService.success == "0"{
                    SVProgressHUD.showError(withStatus: "Error fetching data")
                }
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                
            }catch{
               print(error)
            }
            
        }
        
        
        
    }

}


extension SubServicesTableViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case 0 : return ffsubservice.count
        case 1 : return cgsubservice.count
            case 2 : return edusubservice.count
            case 3 : return sssubservice.count
            case 4 : return msubservice.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hsscell", for: indexPath) as! HomeSubServicesCollectionViewCell
        
            cell.imgView.sd_setImage(with: URL(string: ffsubservice[indexPath.row].img), completed: nil)
        
            cell.titleLbl.text = ffsubservice[indexPath.row].name
        
            return cell
            
        case 1: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hsscell", for: indexPath) as! HomeSubServicesCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: cgsubservice[indexPath.row].img), completed: nil)
        
        cell.titleLbl.text = cgsubservice[indexPath.row].name
        
        return cell
            
        case 2: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hsscell", for: indexPath) as! HomeSubServicesCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: edusubservice[indexPath.row].img), completed: nil)
        
        cell.titleLbl.text = edusubservice[indexPath.row].name
        
        return cell
            
        case 3: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hsscell", for: indexPath) as! HomeSubServicesCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: sssubservice[indexPath.row].img), completed: nil)
        
        cell.titleLbl.text = sssubservice[indexPath.row].name
        
        return cell
            
        default: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hsscell", for: indexPath) as! HomeSubServicesCollectionViewCell
        
        print(msubservice[indexPath.row].name)
        cell.imgView.sd_setImage(with: URL(string: msubservice[indexPath.row].img), completed: nil)
        
        cell.titleLbl.text = msubservice[indexPath.row].name
        
        return cell
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag{
        case 0 : if ffsubservice[indexPath.row].url == ""{
            goToServices(categoryid: ffsubservice[indexPath.row].id, title: ffsubservice[indexPath.row].name)
        }else{
            goToWebView(url: ffsubservice[indexPath.row].url, title: ffsubservice[indexPath.row].name)
            }
            
            
        case 1 : if cgsubservice[indexPath.row].url == ""{
            goToServices(categoryid: cgsubservice[indexPath.row].id, title: cgsubservice[indexPath.row].name)
        }else{
            goToWebView(url: cgsubservice[indexPath.row].url, title: cgsubservice[indexPath.row].name)
            }
        case 2 : if edusubservice[indexPath.row].url == ""{
            goToServices(categoryid: edusubservice[indexPath.row].id, title: edusubservice[indexPath.row].name)
        }else{
            goToWebView(url: edusubservice[indexPath.row].url, title: edusubservice[indexPath.row].name)
            }
        case 3 : if sssubservice[indexPath.row].url == ""{
            goToServices(categoryid: sssubservice[indexPath.row].id, title: sssubservice[indexPath.row].name)
        }else{
            goToWebView(url: sssubservice[indexPath.row].url, title: sssubservice[indexPath.row].name)
            }
        default : if msubservice[indexPath.row].url == ""{
            goToServices(categoryid: msubservice[indexPath.row].id, title: msubservice[indexPath.row].name)
        }else{
            goToWebView(url: msubservice[indexPath.row].url, title: msubservice[indexPath.row].name)
            }
        
        }
    }
    
    
    private func goToServices(categoryid : String, title : String){
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicesVC") as! ServiceProductViewController
        
        
        if let navigator = self.navigationController {
            viewController.productid = categoryid
            viewController.homeTitle = title
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
        
    }
    
    
    private func goToWebView(url : String, title : String){
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as! LoadSubviewInURLViewController
        
        
        if let navigator = self.navigationController {
            viewController.weburl = url
            viewController.homeTitle = title
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
}
