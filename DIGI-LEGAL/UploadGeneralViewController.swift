//
//  GeneralUpLoadViewController.swift
//  DIGI-LEGAL
//
//  Created by srikanth on 10/4/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos


import MobileCoreServices
import AVFoundation



class UploadGeneralViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    @IBOutlet var upLoadedBtnLabel: UIButton!
    
    var fileNameObj:String!
    
    @IBOutlet var hideLabel: UILabel!
    
    var movieData: NSData?
    var dataTask:URLSessionDataTask?
    
    var strUrl:String!
    var last4:String!
    
    
    //    var videoUrl: NSURL? = nil
    
    var associateStored:Int!
    var masterIdStored:Int!
    var associateNameStored:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        associateStored =  UserDefaults.standard.integer(forKey: "key1")
        
        masterIdStored =  UserDefaults.standard.integer(forKey: "key2")
        associateNameStored =  UserDefaults.standard.string(forKey: "key3")
        
        print("associateStored is :\(associateStored)")
        print("masterIdStored is :\(masterIdStored)")
        
        print("associateNameStored is :\(associateNameStored)")
        
        
        
        upLoadedBtnLabel.layer.cornerRadius = 5
        upLoadedBtnLabel.clipsToBounds = true
        
        self.navigationItem.title = "GENERAL UPLOAD"
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
    @IBAction func filePickedBtn(_ sender: Any) {
        
        
        self.uploadUrl()
    }
    
    func uploadUrl(){
        
        
        
        let imagepicker = UIImagePickerController()
        
        imagepicker.delegate = self
        
        //imagepicker.allowsEditing = true
        imagepicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String,kUTTypeMP3 as String,kUTTypePDF as String,kUTTypePNG as String,kUTTypeRTF as String,kUTTypeJPEG as String,kUTTypeText as String,kUTTypeAudio as String,kUTTypeLivePhoto as String]
        
        
        let actionSheet = UIAlertController(title: "Choose your option", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)
                
            {
                imagepicker.sourceType = .camera
                
                self.present(imagepicker, animated: true, completion: nil)
                
            }
                
            else
            {
                self.DisplayMyAlertMessage(userMessage: "Device has no Camera")
            }
            
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagepicker.sourceType = .photoLibrary
            
            
            self.present(imagepicker, animated: true, completion: nil)
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func DisplayMyAlertMessage(userMessage:String)
        
    {
        let myalert = UIAlertController(title: "MyAlert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        
        //imagepicker.allowsEditing = false
        if let pickedImage = info[UIImagePickerControllerOriginalImage] {
            
            print("image is:\(pickedImage)")
            
            
            
             imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage as? UIImage
            
            hideLabel.isHidden = true
            
            if let imageURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
                let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL as URL], options: nil)
                
                
                let fileNameObj = result.lastObject?.value(forKey: "filename") as? String ?? "Unknown"
                UserDefaults.standard.set(fileNameObj, forKey: "key4")
                
                
                self.fileNameLabel.text = fileNameObj
                picker.dismiss(animated: true, completion: nil)
                
                
                print("filename is:\(fileNameObj)")
                
            }
        }
        
        
      //  let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let videoUrl =  info[UIImagePickerControllerMediaURL] as? URL {
           
            
            strUrl = videoUrl.absoluteString
            
            last4 = strUrl.substring(from:strUrl.index(strUrl.endIndex, offsetBy: -10))
            
            
            self.fileNameLabel.text = last4
            
            picker.dismiss(animated: true, completion: nil)
            print("videourl is:\(String(describing: strUrl))")
            print("last4 is:\(String(describing: last4))")
            
        }
        
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func upLoadBtn(_ sender: Any)
        
    {
        
        if self.fileNameLabel.text == "FILE NAME"
        
        {
            self.DisplayMyAlertMessage(userMessage: "Please choose File to Upload")
            return
        }
        
        else
        {

        
        
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
        let myUrl = NSURL(string: "http://digilegal.neviton.com:8080/Legal-app/uploadGenDoc");
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        
        
        let obj1:String = String(masterIdStored)
        let obj2:String = String(associateStored)
        let obj3:String = String(associateNameStored)
        
        
        print("obj1 is:\(obj1)")
        let param = [
            "masterClientId"  : obj1,
            "uploaderId"      : obj2,
            "uploaderName"    : obj3
            ] as [String : Any]
        
        print("param is:\(param)")
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let image = UIImagePNGRepresentation(imageView.image!) as NSData?
        
        
        print("images is:\(String(describing: image))")
        if(image==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param as? [String : String], filePathKey: "file" as! String, imageDataKey: image! as NSData, boundary: boundary) as Data
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let alert = UIAlertView(title: "Error", message: "Could not connect to the server check your wifi or mobile data", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    self.dismiss(animated: false, completion: nil)
                })
                
                return
            }
            
            
            
            let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(dataString)
            
            let respVO:[RespVo] = Mapper<RespVo>().mapArray(JSONString: dataString! as String)!
            
            print("responseString = \(respVO)")
            
            let successResp = respVO[0].response
            
            
            
            
            let statusResp = "Documents saved successfully"
            
            if successResp! == (statusResp as NSString) as String {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    //                    self.submitOutlet.isUserInteractionEnabled = false
                    
                    
                    let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomSecondAlertViewController") as! CustomSecondAlertViewController
                    
                    ViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    
                    self.addChildViewController(ViewController)
                    self.view.addSubview(ViewController.view)
                    
                    self.fileNameLabel.text = "File Name"
                    self.imageView.image = UIImage(named: "upload")
                    
                    self.hideLabel.isHidden = false

                    
                    self.hideLabel.text = "CHOOSE FILE TO UPLOAD"
                    
                    self.dismiss(animated: false, completion: nil)
                    
                   
                })
                
                
            }
            
        }
        
        task.resume()
    }
}

    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        //var body = Data();
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        
        let imgObj = fileNameLabel.text
        let videoObj = fileNameLabel.text
        
        let newImg = UserDefaults.standard.string(forKey: "key4")
        
        
        if imgObj == newImg{
            
            
            //let newObj = "manu.jpg"
            //let manuObj = fileNameLabel.text
            body.appendString(string: "--\(boundary)\r\n")
            
            let mimetype = "image/jpg"
            
            //let defFileName = fileNameObj
            
            
            
            let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
            print("defFileName is :\(String(describing: imageData))")
            
            let fnamed = fileNameLabel.text
            print("fnamed is:\(fnamed!)")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fnamed!)\"\r\n")
            
            print("njsc is:\( body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fnamed!)\"\r\n"))")
            
            body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageData!)
            body.appendString(string: "\r\n")
            body.appendString(string: "--\(boundary)--\r\n")
            
            
        }
        else {
            let kBoundary = "Boundary-\(UUID().uuidString)"
            let kStartTag = "--%@\r\n"
            let kEndTag = "\r\n"
            let kContent = "Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
            
            
            
            body.append(String(format: kStartTag, boundary).data(using: String.Encoding.utf8)!)
            body.append(String(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", "file", last4!).data(using: String.Encoding.utf8)!)
            body.append("Content-Type: video/mp4\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.appendString(string: strUrl)
            body.append(String(format: kEndTag).data(using: String.Encoding.utf8)!)
            
            // close form
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        }
        return body as NSData
    }
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    func Displaymyalertmessage(usermessage:String)
    {
        
        let  myalert = UIAlertController(title: "Alert", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
        
    }
    
    
}


extension Data {
    mutating func appendString(string: String) {
        append(string.data(using: .utf8)!)
    }
}


