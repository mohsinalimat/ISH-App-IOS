//
//  UploadDocumentCell.swift
//  ISH
//
//  Created by Admin on 14/06/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class UploadDocumentCell: UITableViewCell,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    
    

    
    var viewController : UIViewController?
    
    @IBOutlet weak var LabelAttachName: UILabel!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var AttachBtn: UIButton!
    @IBAction func AttachBtn(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        viewController!.present(documentPicker, animated: true, completion: nil)
//         viewController!.present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func UploadBtn(_ sender: UIButton) {
        
    }
    
    
    func uploadDOC(fileName : String, data : Data, mimeType : String) {
        
        
        SVProgressHUD.show()
        
        // User "authentication":
        let parameters = ["hashkey":AppDelegate.apiKey]
        
        
        // Server address (replace this with the address of your own server):
        let url = "https://indiansmarthub.net/webservice/order_documents.php"
        
        // Use Alamofire to upload the image
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
                
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                }
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let json = JSON(response.result.value)
                        if json["success"].intValue == 1{
                            SVProgressHUD.showSuccess(withStatus: "File Uploaded Successfully. You can proceed with your order.")
                        }else{
                            SVProgressHUD.showSuccess(withStatus: "Unable to upload")
                        }
                    }
                case .failure(let encodingError):
                    SVProgressHUD.dismiss()
                    print(encodingError)
                }
        }
        )
    }
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        
        
        do{
            let fileData = try Data.init(contentsOf: myURL)
            
            uploadDOC(fileName: myURL.pathComponents.last!, data: fileData, mimeType: myURL.pathExtension)
            LabelAttachName.text = myURL.pathComponents.last!
//            print("ghjhk"+myURL.pathExtension)
//            print("ghjhk"+myURL.path)
//            print(myURL.pathComponents.last)
            
            
        }catch{
            
            print("error converting file to data \n \(error)")
        }
        
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
