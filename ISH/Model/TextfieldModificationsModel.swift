//
//  TextfieldModificationsModel.swift
//  ISH
//
//  Created by Admin on 10/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit

extension UITextField{
    
    
    func setLeftViewImages(icon : UIImage){
        
        let arrow = UIImageView(image: icon)
        
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10, height: size.height + 10)
        }
        arrow.contentMode = UIView.ContentMode.center
        
        self.leftView = arrow
        self.leftViewMode = UITextField.ViewMode.always
        
        
    }
    
    
    func setRightViewImages(icon : UIImage){
        
        let arrow = UIImageView(image: icon)
        
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10, height: size.height + 10)
        }
        arrow.contentMode = UIView.ContentMode.center
        
        self.rightView = arrow
        self.rightViewMode = UITextField.ViewMode.always
        
        
    }
    
}


