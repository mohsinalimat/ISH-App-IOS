//
//  LoadSubviewInURLViewController.swift
//  ISH
//
//  Created by Admin on 03/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoadSubviewInURLViewController: UIViewController {

    var weburl = ""
    var homeTitle = ""
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = homeTitle
        
        let url = URL (string: weburl)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
        
        
        // Do any additional setup after loading the view.
    }
    

   

}
