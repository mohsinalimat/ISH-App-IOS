////
////  HomeViewController.swift
////  ISH
////
////  Created by Admin on 14/05/19.
////  Copyright © 2019 Indian Smart Hub. All rights reserved.
////
//
//import UIKit
//import Blueprints
//
//
//
//class HomeOurServiceCell : UITableViewCell{
//    
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    
//}
//
//
//class HomeCollectionCell : UITableViewCell{
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//}
//
//
//class HomeViewController: UIViewController{
//    
//    
//    var rightButtonItem: UIBarButtonItem!
//   
//    
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    //    Navigationbar-logout-rounded-up-72
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//       
//        
////        self.tableView.rowHeight = UITableView.automaticDimension;
////        self.tableView.estimatedRowHeight = 400.0
//        
//        self.tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "scell")
//        
//        
//    
//        
//        
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    
//
//
//
//extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch indexPath.section{
//        case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "oscell", for: indexPath) as! HomeOurServiceCell
//        
//        return cell
//        case 1 : let cell = tableView.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as! SliderTableViewCell
//            
//            return cell
//            
//        default:  let cell = tableView.dequeueReusableCell(withIdentifier: "hccell", for: indexPath) as! HomeCollectionCell
//        
//        return cell
//        
//        }
//        
//        
//       
//    }
//    
////    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 1500
////    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        switch indexPath.section{
//        case 0: return 150
//        case 1 : return 200
//        default : return 1250
//        }
//        
//    }
//    
//    
//    func goToServices(){
//        
//        goToPage(goto: "Services")
//        
//        
//    }
//    
//}
//
//
//protocol SetRightBarButtonDelegate {
//    var rightButtonItem : UIBarButtonItem!{ get }
//    
//}
