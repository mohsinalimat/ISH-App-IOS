//
//  SliderTableViewCell.swift
//  ISH
//
//  Created by Admin on 15/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import FSPagerView
import SVProgressHUD

class SliderTableViewCell: UITableViewCell,  FSPagerViewDelegate, FSPagerViewDataSource {
   
    // variables
    private var img = [String]()
    private var title = [String]()
    private var id = [String]()
    
    var flag = true
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pagerView.delegate = self
        pagerView.dataSource = self
        if flag{
            SVProgressHUD.show()
            getData()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return id.count ?? 1
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: img[index]), completed: nil)
//      cell.textLabel?.text = title[index]
        return cell
        
    }
    
    
    private func getData(){
        alamofireRequest(url: "slider.php", params: ["hashkey":AppDelegate.apiKey]) { (json, data) in
            
            do{
                let slider = try JSONDecoder().decode(HomeSliderRoot.self, from: data)
                
                if slider.success == "1"{
                    
                    self.flag = false
                    
                    for x in slider.slider{
                        self.id.append(x.id)
                        self.title.append(x.title)
                        self.img.append(x.image)
                    }
                }else{
                   SVProgressHUD.showError(withStatus: slider.message)
                }
//                SVProgressHUD.dismiss()
                self.pagerView.reloadData()
            }catch{
               print(error)
            }
            
        }
    }
    
    
}
