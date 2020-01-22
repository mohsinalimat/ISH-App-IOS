//
//  WalletViewController.swift
//  ISH
//
//  Created by Admin on 24/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD
import ChameleonFramework

class WalletCell : UITableViewCell{
    
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
}


class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    private struct Wallet{
        var id : String
        var points : String
        var date : String
        var comment : String
    }
    
    private var wallets = [Wallet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        getData()
    }
    
    
    
    
    private func getData(){
        if let userID = defaults.string(forKey: "userID"){
            SVProgressHUD.show()
            alamofireRequest(url: "reward_history.php", params: ["hashkey":AppDelegate.apiKey,"custid":userID]) { (json, data) in
                
                do{
                    let wallet = try JSONDecoder().decode(WalletRoot.self, from: data)
                    
                    if wallet.success == 1{
                        
                        for x in wallet.customerHistory{
                            self.wallets.append(Wallet(id: x.id, points: x.point, date: x.date, comment: x.comment))
                        }
                        
                    }else if wallet.success == 0{
                        
                        SVProgressHUD.showError(withStatus: wallet.message)
                        
                    }
                    self.balanceLbl.text = wallet.balance
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
                
                
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wcell", for: indexPath) as! WalletCell
        
        if wallets[indexPath.row].points.contains("-"){
            cell.point.textColor = UIColor.flatRed
        }else if wallets[indexPath.row].points.contains("+"){
            cell.point.textColor = UIColor.flatGreen
        }
        
        cell.commentLbl.text = wallets[indexPath.row].comment
        cell.dateLbl.text = wallets[indexPath.row].date
        cell.point.text = wallets[indexPath.row].points
        return cell
    }
    
}
