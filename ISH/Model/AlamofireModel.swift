//
//  AlamofireModel.swift
//  ISH
//
//  Created by Admin on 10/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import SVProgressHUD

//var x = 0
func alamofireRequest(url: String, params : [String:String], completion : @escaping (JSON, Data) -> Void ){
    
    
    let baseURL = "https://indiansmarthub.net/webservice/"
    
    request(baseURL+url, method: .post, parameters: params).responseJSON{
        response in
        
        
        let apiJSON : JSON = JSON(response.result.value)
        
        print(baseURL+url)
        print(params)
//        x+=1
//        print("ytyiugtu "+String(x+1))
        print(apiJSON)
        
        if response.result.isSuccess{
            
//            print(baseURL+url)
            
            
            completion(apiJSON,response.data!)
            
            
            
            
            
        }else{
            
            if let error = response.result.error{
                print(error)
            }
            
        }
    }
    
}


func alamofireImageRequest(url:String, completion : @escaping (UIImage) -> Void){
    
    request(url).responseImage { response in
        
        if let image = response.result.value {
            completion(image)
            
        }
    }
    
    
}



func alamofireCartRequest(url: String, params : [String:String], completion : @escaping (JSON, Data) -> Void ){
    
    
    let baseURL = "https://indiansmarthub.net/webservice/"
    
    request(baseURL+url, method: .post, parameters: params).responseJSON{
        response in
        
        
        let apiJSON : JSON = JSON(response.result.value)
        
        print(baseURL+url)
        print(params)
        print(apiJSON)
        
        if response.result.isSuccess{
            
            //            print(baseURL+url)
            
            
            completion(apiJSON,response.data!)
            
            
            
            
            
        }else{
            
            if let error = response.result.error{
                print(error)
            }
            
        }
    }
    
    
    
    func requestMultiPart(data : Data, url : String)
    {
        
        
        if NetworkReachabilityManager()?.isReachable == true
        {
            
            Alamofire.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
                
                multipartFormData.append(data, withName: "json")
                
            }, to: url, method: .post, headers: [:], encodingCompletion: { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
                switch encodingResult
                {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (Response) in
                     
                        print(Response)
                        
                    })
                case .failure(let error): break
                
                }
            })
        }
        else
        {
          SVProgressHUD.showError(withStatus: "No network connection")
        }
    }
    
    

    
}
