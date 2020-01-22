//
//  SearchViewController.swift
//  ISH
//
//  Created by Admin on 14/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Blueprints
import SVProgressHUD

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private struct SearchedProduct{
        var prodID : String
        var img : String
        var prodName : String
        var prodPrice : String
        var wishlist : String
        var prodSku : String
    }
    
    private var searchedProds = [SearchedProduct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchView.delegate = self
        
        
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
        collectionView.isScrollEnabled = true
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pcell")
        
        searchView.becomeFirstResponder()
        
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "SEARCH"
        getBadgeValues()
    }

   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchView.showsCancelButton = true
        
        
        
        getData(searchText: searchText)
        print(searchText.count)
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
  
        //        searchView.text = ""
        print(searchView.text?.count)
        
        searchView.showsCancelButton = false
        self.dismissKeyboard()
    }
    
    
    private func getData(searchText : String){
        
        alamofireRequest(url: "productSearch.php", params: ["hashkey":AppDelegate.apiKey, "name" : searchText]) { (json, data) in
            do{
                self.searchedProds = [SearchedProduct]()
                
                if json["success"].stringValue == "1"{
                    let search = try  JSONDecoder().decode(SearchRoot.self, from: data)
                
                        for x in search.search{
                        
                            self.searchedProds.append(SearchedProduct(prodID: x.id, img: x.image, prodName: x.name, prodPrice: x.price, wishlist: x.wishlist, prodSku: x.sku))
                        }
                }
                
                self.collectionView.reloadData()
                
            }catch{
                print(error)
            }
        }
        
        
    }
    

}



extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedProds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pcell", for: indexPath) as! ProductCollectionViewCell
        
        cell.imgView.sd_setImage(with: URL(string: searchedProds[indexPath.row].img), completed: nil)
        cell.price.text = "₹"+searchedProds[indexPath.row].prodPrice
        cell.productName.text = searchedProds[indexPath.row].prodName
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionVC") as! ProductDescriptionViewController
        
        
        if let navigator = self.navigationController {
            viewController.prodid = searchedProds[indexPath.row].prodID
            navigator.pushViewController(viewController, animated: true)
        }else{
            print("unable to navigate")
        }
    }
    
    
    
}
