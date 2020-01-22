//
//  OrdersTableViewController.swift
//  ISH
//
//  Created by Admin on 25/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD

class OrdersCell : UITableViewCell{
    
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var statusView: UIView!{
        didSet{
            statusView.changeCornerRadiusOfTheView(borderWidth: 1, cornerRadius: statusView.frame.size.width / 2, borderColor: UIColor.flatWhite.cgColor)
        }
    }
    @IBOutlet weak var statusLbl: UILabel!
    
}


class OrdersTableViewController: UITableViewController {

    
    private struct Order{
    
        var id : String
        var deliveryCharges : String
        var rewardUsed : String
        var orderDate : String
        var baseSubTotal : String
        var orderTotal : String
        var status : String
        var expectedTime : String
        
    }
    
    private var orderID = ""
    private var status = ""
    private var statustext = ""
    
    private var orders = [Order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        getData()
    }
    
   

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ocell", for: indexPath) as! OrdersCell
        
        cell.amount.text = orders[indexPath.row].baseSubTotal
        cell.dateTime.text = orders[indexPath.row].orderDate
        cell.order.text = "Order #"+orders[indexPath.row].id
        
        if orders[indexPath.row].status == "approved"{
            cell.statusView.backgroundColor = UIColor.flatGreen
            cell.statusLbl.textColor = UIColor.flatGreen
        }else if orders[indexPath.row].status == "canceled"{
            cell.statusView.backgroundColor = UIColor.flatRed
            cell.statusLbl.textColor = UIColor.flatRed
        }else if orders[indexPath.row].status == "holded"{
            cell.statusView.backgroundColor = UIColor.flatSkyBlue
            cell.statusLbl.textColor = UIColor.flatSkyBlue
        }else{
            cell.statusView.backgroundColor = UIColor.flatOrange
            cell.statusLbl.textColor = UIColor.flatOrange
        }
        
        cell.statusLbl.text = orders[indexPath.row].expectedTime
        
        return cell
    }

    private func getData(){
        
        if let userID = defaults.string(forKey: "userID"){
             SVProgressHUD.show()
            alamofireRequest(url: "customerOrder.php", params: ["hashkey":AppDelegate.apiKey,"custid":userID]) { (json, data) in
                
                do{
                    self.orders = [Order]()
                    
                    let order = try JSONDecoder().decode(OrdersRoot.self, from: data)
                    
                    if order.success == 1{
                        
                        for x in order.customerOrder{
                            self.orders.append(Order(id: x.orderid, deliveryCharges: x.deliveryCharge, rewardUsed: x.rewardused, orderDate: x.orderdate, baseSubTotal: x.baseSubtotal, orderTotal: x.ordertotal, status: x.status, expectedTime: x.expectedTime))
                        }
                        
                    }else if order.success == 0{
                        
                        SVProgressHUD.showError(withStatus: order.message)
                        
                    }
                    
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
                
                
            }
            
        }
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.orderID = orders[indexPath.row].id
        self.status = orders[indexPath.row].status
        self.statustext = orders[indexPath.row].expectedTime
        
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
            
            let vc = segue.destination as! OrderDetailsTableViewController
            vc.orderid = self.orderID
            vc.status = self.status
            vc.statusText = self.statustext
        }
    }
    
    

}
