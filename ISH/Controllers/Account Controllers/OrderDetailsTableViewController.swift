//
//  OrderDetailsTableViewController.swift
//  ISH
//
//  Created by Admin on 25/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD



class OrderDetailsTableViewController: UITableViewController {
    
    
    var orderid = ""
    var status = ""
    var statusText = ""
    
    private struct Price{
        
        var tax : String
        var delivery : String
        var file : String
        var points : String
        var discount : String
        var subtotal : String
        var date : String
        var status : String
        
    }
    
    
    private struct Shipping{
        
        var fname : String
        var lname : String
        var company : String
        var street : String
        var city : String
        var region : String
        var pincode : String
        var countryID : String
        var telephone : String
        var shipmentID : String
        
    }
    
    
    private struct Item{
        
        var id : String
        var name : String
        var sku : String
        var price : String
        var qty : String
        
    }
    
    private var paymentMethod = ""
    private var price : Price? = nil
    private var ship : Shipping? = nil
    private var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.dismiss()
        
        self.tableView.register(UINib(nibName: "OrderIDTableViewCell", bundle: nil), forCellReuseIdentifier: "oidcell")
        self.tableView.register(UINib(nibName: "OrderItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "oicell")
        self.tableView.register(UINib(nibName: "OrderShippingDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "oscell")
        self.tableView.register(UINib(nibName: "OrderPriceDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "opcell")
        
        
        
        getData()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 3 : return items.count
        default : return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
            
        case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "oidcell", for: indexPath) as! OrderIDTableViewCell
        cell.idLbl.font = cell.idLbl.font.withSize(15)
        cell.idLbl.textAlignment = .center
        
        
        if status == "approved"{
            cell.idLbl.backgroundColor = UIColor.flatGreen
            cell.idLbl.textColor = UIColor.flatWhite
        }else if status == "canceled"{
            cell.idLbl.backgroundColor = UIColor.flatRed
            cell.idLbl.textColor = UIColor.flatWhite
        }else if status == "holded"{
            cell.idLbl.backgroundColor = UIColor.flatSkyBlue
            cell.idLbl.textColor = UIColor.flatWhite
        }else{
            cell.idLbl.backgroundColor = UIColor.flatOrange
            cell.idLbl.textColor = UIColor.flatWhite
        }
        
        cell.idLbl.text = status
        
        return cell
            
        case 1 : let cell = tableView.dequeueReusableCell(withIdentifier: "oidcell", for: indexPath) as! OrderIDTableViewCell
        cell.idLbl.font = cell.idLbl.font.withSize(15)
        cell.idLbl.textAlignment = .center
        
        cell.backgroundColor = UIColor.flatWhiteDark
        
        if status == "approved"{
            cell.idLbl.textColor = UIColor.flatGreen
        }else if status == "canceled"{
            cell.idLbl.textColor = UIColor.flatRed
        }else if status == "holded"{
            cell.idLbl.textColor = UIColor.flatSkyBlue
        }else{
            cell.idLbl.textColor = UIColor.flatOrange
        }
        
        cell.idLbl.text = statusText
        return cell
            
        case 2 : let cell = tableView.dequeueReusableCell(withIdentifier: "oidcell", for: indexPath) as! OrderIDTableViewCell
        cell.idLbl.text = "Order #"+orderid
        return cell
            
        case 3 : let cell = tableView.dequeueReusableCell(withIdentifier: "oicell", for: indexPath) as! OrderItemsTableViewCell
        cell.nameLbl.text = items[indexPath.row].name
        cell.priceLbl.text = items[indexPath.row].price
        cell.quantityLbl.text = items[indexPath.row].qty
        return cell
            
        case 4 : let cell = tableView.dequeueReusableCell(withIdentifier: "oscell", for: indexPath) as! OrderShippingDetailsTableViewCell
        guard let x = ship else{return cell}
        cell.nameLbl.text = "\(x.fname) \(x.lname)"
        cell.regionLbl.text = "\(x.region) - \(x.pincode)"
        cell.streetLbl.text = x.street
        cell.cityLbl.text = x.city
        cell.contryLbl.text = x.countryID
        cell.phoneLbl.text = x.telephone
        return cell
            
        case 5 : let cell = tableView.dequeueReusableCell(withIdentifier: "opcell", for: indexPath) as! OrderPriceDetailsTableViewCell
        
        guard let x = price else{return cell}
        cell.deliveryLbl.text = x.delivery
        cell.discountLbl.text = x.discount
        cell.pointsLbl.text = x.points
        cell.taxLbl.text = x.tax
        cell.totalPriceLbl.text = x.subtotal
        return cell
            
        default : let cell = tableView.dequeueReusableCell(withIdentifier: "oidcell", for: indexPath) as! OrderIDTableViewCell
        
        cell.idLbl.font = cell.idLbl.font.withSize(13)
        cell.idLbl.text = "Payment Method : \(paymentMethod)"
        

        return cell
            
        }
    }
    
    private func getData(){
        
        if orderid != ""{
             SVProgressHUD.show()
            
            alamofireRequest(url: "customerOrderDetails.php", params: ["hashkey":AppDelegate.apiKey,"orderid":orderid]) { (json, data) in
                
                do{
                    
                    self.paymentMethod = ""
                    self.price = nil
                    self.ship = nil
                    self.items = [Item]()
                    
                    let order = try JSONDecoder().decode(OrdersDetailsRoot.self, from: data)
                    
                    if order.success == "1"{
                        
                        for x in order.shipment{
                            self.ship = Shipping(fname: x.firstname, lname: x.lastname, company: x.company, street: x.street, city: x.city, region: x.region, pincode: x.postcode, countryID: x.countryID, telephone: x.telephone, shipmentID: x.shipmentid)
                        }
                        
                        for x in order.order{
                            self.price = Price(tax: x.taxAmount , delivery: x.deliveryCharge, file: x.file, points: x.rewardused, discount: x.discountAmount, subtotal: x.subtotal, date: x.date, status: x.status)
                        }
                        
                        for x in order.payment{
                            self.paymentMethod = x.method
                        }
                        
                        for x in order.items{
                            self.items.append(Item(id: x.id, name: x.name, sku: x.name, price: x.price, qty: String(x.qty)))
                        }
                        
                    }else if order.success == "0"{
                        
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
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 3 : return "ITEMS"
        case 4 : return "SHIPPING ADDRESS"
        case 5 : return "PAYMENT DETAILS"
        default : return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
}



