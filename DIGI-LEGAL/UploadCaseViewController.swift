//
//  UploadCaseViewController.swift
//  DIGI-LEGAL
//
//  Created by Apple on 04/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit
import Photos

import AssetsLibrary



import MobileCoreServices
import AVFoundation



class UploadCaseViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate {
    @IBOutlet var uploadClientTxtField: NoCopyPasteUITextField!
    
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var uploadSubsidiaryTableView: UITableView!
    @IBOutlet var uploadCaseTableView: UITableView!
    @IBOutlet var uploadClientTableView: UITableView!
    @IBOutlet var uploadImageView: UIImageView!
    @IBOutlet var uploadSubsidairyTxtField: NoCopyPasteUITextField!
    
    @IBOutlet var hideLabel: UILabel!
    @IBOutlet var uploadCaseTxtField: NoCopyPasteUITextField!
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    
    
    var strUrl:String!
    var last4:String!

    
    let uploadClientCellIdentifier = "cell"
    let uploadCaseCellIdentifier = "cell1"
    let uploadSubsidiaryCellidentifier = "cell2"
    
    
    var uploadClientListArr = [String]()
    var uploadClientIdObj = [Int]()
    
    var uploadCaseListArr = [String]()
    var uploadCaseIdObj = [Int]()
    
    var uploadSubsidiaryListArr = [String]()
    var uploadSubsidiaryIdObj = [Int]()
    
    
    
    var clientIdIndex:Int!
    var caseIdIndex:Int!
    var subsidiaryIndex:Int!
    
    
    var dataTask:URLSessionDataTask?
    
    
    var associateStored:Int!
    var masterIdStored:Int!
    var associateNameStored:String!
    
    
    //final let urlString = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        associateStored =  UserDefaults.standard.integer(forKey: "key1")
        
        masterIdStored =  UserDefaults.standard.integer(forKey: "key2")
        associateNameStored =  UserDefaults.standard.string(forKey: "key3")
        
        print("associateStored is :\(associateStored)")
        print("masterIdStored is :\(masterIdStored)")
        
        print("associateNameStored is :\(associateNameStored)")
        
        
        
        self.navigationItem.title = "CASE RELATED UPLOAD"
        
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        uploadClientTxtField.layer.borderColor = UIColor.gray.cgColor
        uploadClientTxtField.layer.borderWidth = 1.0
        uploadClientTxtField.layer.cornerRadius = 5
        uploadClientTxtField.layer.masksToBounds = false
        
        uploadCaseTxtField.layer.borderColor = UIColor.gray.cgColor
        uploadCaseTxtField.layer.borderWidth = 1.0
        uploadCaseTxtField.layer.cornerRadius = 5
        uploadCaseTxtField.layer.masksToBounds = false
        
        uploadSubsidairyTxtField.layer.borderColor = UIColor.gray.cgColor
        uploadSubsidairyTxtField.layer.borderWidth = 1.0
        uploadSubsidairyTxtField.layer.cornerRadius = 5
        uploadSubsidairyTxtField.layer.masksToBounds = false
        
        
        self.uploadClientTableView.register(UITableViewCell.self, forCellReuseIdentifier: uploadClientCellIdentifier)
        self.uploadCaseTableView.register(UITableViewCell.self, forCellReuseIdentifier: uploadCaseCellIdentifier)
        self.uploadSubsidiaryTableView.register(UITableViewCell.self, forCellReuseIdentifier: uploadSubsidiaryCellidentifier)
        
        
        uploadClientTableView.layer.cornerRadius = 10
        uploadClientTableView.isHidden = true
        uploadCaseTableView.layer.cornerRadius = 10
        uploadCaseTableView.isHidden = true
        uploadSubsidiaryTableView.layer.cornerRadius = 10
        uploadSubsidiaryTableView.isHidden = true
        
        
        uploadClientTxtField.addTarget(self, action: #selector(textFieldActive), for: UIControlEvents.touchDown)
        uploadCaseTxtField.addTarget(self, action: #selector(caseFieldActive), for: UIControlEvents.touchDown)
        
        uploadSubsidairyTxtField.addTarget(self, action: #selector(subsidiaryFieldActive), for: UIControlEvents.touchDown)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.fetchSelectClients()
        self.fetchSelectCases()
        
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 200
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 200
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        //         self.view.endEditing(true)
        
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != uploadClientTableView
        {
            uploadClientTxtField.endEditing(true)
            uploadClientTableView.isHidden = true
        }
        if touch.view != uploadCaseTableView
        {
            uploadCaseTxtField.endEditing(true)
            uploadCaseTableView.isHidden = true
        }
        
        if touch.view != uploadSubsidiaryTableView
        {
            uploadSubsidairyTxtField.endEditing(true)
            uploadSubsidiaryTableView.isHidden = true
        }
    }
    
    
    func textFieldActive() {
        
        //        DispatchQueue.main.async(execute: { () -> Void in
        
        //             self.tableView.isHidden = !self.tableView.isHidden
        //        self.fetchAutocompletePlaces()
        //uploadClientTableView.isHidden = true
        uploadSubsidiaryTableView.isHidden = true
        uploadCaseTableView.isHidden = true
        if uploadClientTableView.isHidden {
            
            uploadClientTableView.isHidden = false
            
        }
        else{
            
            uploadClientTableView.isHidden = true
            
        }
    }
    
    func subsidiaryFieldActive() {
        
        uploadClientTableView.isHidden = true
        uploadCaseTableView.isHidden = true
        uploadSubsidiaryTableView.isHidden = !uploadSubsidiaryTableView.isHidden
        
    }
    
    func caseFieldActive() {
        
        uploadClientTableView.isHidden = true
        uploadSubsidiaryTableView.isHidden = true
        uploadCaseTableView.isHidden = !uploadCaseTableView.isHidden
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TODO: Your app can do something when textField finishes editing
        print("The textField ended editing. Do something based on app requirements.")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(false)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == uploadCaseTxtField {
            
            self.uploadCaseTxtField.text = ""
            
            
        }
        
        return false //do not show keyboard nor cursor
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.uploadClientTableView {
            count = uploadClientListArr.count
        }
        if tableView == self.uploadCaseTableView {
            count = uploadCaseListArr.count
        }
        if tableView == self.uploadSubsidiaryTableView {
            count = uploadSubsidiaryListArr.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        var cell:UITableViewCell?
        
        // Set text from the data model
        
        if tableView == self.uploadClientTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = uploadClientListArr[indexPath.row]
            cell?.textLabel?.font = uploadClientTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        if tableView == self.uploadCaseTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell?.textLabel?.text = uploadCaseListArr[indexPath.row]
            cell?.textLabel?.font = uploadCaseTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        if tableView == self.uploadSubsidiaryTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell?.textLabel?.text = uploadSubsidiaryListArr[indexPath.row]
            cell?.textLabel?.font = uploadSubsidairyTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        
        if tableView == self.uploadClientTableView
        {
            
            uploadClientTxtField.text = uploadClientListArr[indexPath.row]
            
            self.clientIdIndex = uploadClientIdObj[indexPath.row]
            
            print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            
            self.uploadCaseListArr.removeAll()
            
            self.postMethodUploadCase()
            
            uploadClientTableView.isHidden = true
            uploadClientTxtField.endEditing(true)
            
            
        }
        if tableView == self.uploadCaseTableView {
            
            uploadCaseTxtField.text = uploadCaseListArr[indexPath.row]
            
            self.caseIdIndex = uploadCaseIdObj[indexPath.row]
            
            print("clientIdIndex:\(self.caseIdIndex as Int)")
            
            uploadCaseTableView.isHidden = true
            uploadCaseTxtField.endEditing(true)
            
        }
        if tableView == self.uploadSubsidiaryTableView {
            
            uploadSubsidairyTxtField.text = uploadSubsidiaryListArr[indexPath.row]
            
            self.subsidiaryIndex = uploadSubsidiaryIdObj[indexPath.row]
            
            print("clientIdIndex:\(self.subsidiaryIndex as Int)")
            
            uploadSubsidiaryTableView.isHidden = true
            uploadSubsidairyTxtField.endEditing(true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    @IBAction func chooseFileButton(_ sender: Any) {
        
        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //imagepicker.allowsEditing = false
        if let pickedImage = info[UIImagePickerControllerOriginalImage] {
            
            print("image is:\(pickedImage)")
            
            
            
            uploadImageView.contentMode = .scaleAspectFit
            uploadImageView.image = pickedImage as? UIImage
            
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
    
    
    func fetchSelectClients() {
        
        let urlString = "http://digilegal.neviton.com:8080/Legal-app/getClientList"
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let data = data{
                    
                    do{
                        
                        let result = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                        
                        for (index, element) in (result.enumerated()) {
                            print("Item \(index): \(element)")
                            
                            
                            self.uploadClientListArr.append(element["clientName"] as! String)
                            
                            self.uploadClientIdObj.append(element["clientId"] as! Int)
                            
                            //                                print("clientNameList:\(self.clientIdObj)")
                            
                            
                        }
                        
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.uploadClientTableView.reloadData()
                        })
                    }
                    catch let error as NSError{
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    
    
    func fetchSelectCases() {
        
        let urlString = "http://digilegal.neviton.com:8080/Legal-app/getCaseList"
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let data = data{
                    
                    do{
                        
                        let result = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                        
                        for (index, element) in (result.enumerated()) {
                            print("Item \(index): \(element)")
                            
                            
                            self.uploadCaseListArr.append(element["caseType"] as! String)
                            
                            self.uploadCaseIdObj.append(element["caseId"] as! Int)
                            
                            //                            print("caseList:\(self.caseList)")
                            
                            
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.uploadCaseTableView.reloadData()
                        })
                    }
                    catch let error as NSError{
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })
            dataTask?.resume()
        }
    }
    
    func  postMethodCase() {
        
        let clientID:String = String(clientIdIndex)
        print("clientId is:\(clientID)")
        
        let json = ["client":clientID] as [String : Any]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        
        //    let obj = "jesuschrist"
        //
        //        let body: NSString = NSString(format:"{\"message\":%@}", obj)
        
        var request = URLRequest(url: URL(string: "http://digilegal.neviton.com:8080/Legal-app/getSubClientList")!)
        request.httpMethod = "POST"
        
        let postData:NSData?  =  jsonData as NSData?
        
        
        let postLength:NSString = NSString(format:"%d",postData!.length)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.httpBody = postData as Data?
        
        //        request.httpBody = body.data(using: .max)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let alert = UIAlertView(title: "Error", message: "Could not connect to the server check your wifi or mobile data", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    self.dismiss(animated: false, completion: nil)
                })
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                self.dismiss(animated: false, completion: nil)
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            
            
            print("responseString = \(responseString)")
            
            
            //            let responseObj = String(data: data, encoding: .utf8)
            
            
            let respVO:[SubRespVo] = Mapper<SubRespVo>().mapArray(JSONString: responseString!)!
            
            print("responseString = \(respVO)")
            
            
            for (index, element) in (respVO.enumerated()) {
                print("Item \(index): \(element)")
                
                
                self.uploadSubsidiaryListArr.append(element.subClientName!)
                
                //                    = [element.subClientName! as String]
                self.uploadSubsidiaryIdObj.append(element.subClientId!)
                
                
            }
            
            
            //            self.subsidiaryIdObj  = [respVO[0].subClientId!]
            //             self.subsidiaryNameArr  = [respVO[0].subClientName!]
            //
            //            self.subsidiaryIdObj  = [respVO[1].subClientId!]
            //            self.subsidiaryNameArr  = [respVO[1].subClientName!]
            
            print("subsidiaryidObj is:\(self.subsidiaryIndex)")
            //print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.uploadSubsidiaryTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
    
    @IBAction func uploadedBtnTapped(_ sender: Any) {
        
        if uploadClientTxtField.text == ""
        {
            
            self.Displaymyalertmessage(usermessage:"Please select the ClientName")
            return
        }
        
        if uploadCaseTxtField.text == ""
        {
            
            self.Displaymyalertmessage(usermessage:"Please select the Case")
            return
        }
            
        if fileNameLabel.text == "FILE NAME"
        {
            
            self.Displaymyalertmessage(usermessage:"Please choose File to Upload")
            return
        }
            

        
//        if uploadSubsidairyTxtField.text == ""
//        {
//            
//            self.Displaymyalertmessage(usermessage:"Please select the Subsidairy")
//            return
//        }
        else
        {
            
            
            
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating()
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            

            
            
            
            let clientID:String = String(clientIdIndex)
            let caseID:String = String(caseIdIndex)
           // let subId:String = "0"
            let obj1:String = String(masterIdStored)
            let obj2:String = String(associateStored)
            let obj3:String = String(associateNameStored)
            
            let myUrl = NSURL(string: "http://digilegal.neviton.com:8080/Legal-app/uploadCaseDoc");
            //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
            
            let request = NSMutableURLRequest(url:myUrl! as URL)
            request.httpMethod = "POST"
            
            let param = [
                "masterClientId"  : obj1,
                "uploaderId"      : obj2,
                "uploaderName"    : obj3,
                "caseId":caseID,
                " clientId":clientID,
                " subClientId":"0",
                ] as [String : Any]
            
            let boundary = generateBoundaryString()
            
            
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let image = UIImagePNGRepresentation(uploadImageView.image!) as NSData?
            
            //let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
            
            print("images is:\(String(describing: image))")
            if(image==nil)  { return; }
            
            request.httpBody = createBodyWithParameters(parameters: param as? [String : String], filePathKey: "file" as! String, imageDataKey: image! as NSData, boundary: boundary) as Data
            
            
            print("jnjce is:\(String(describing: request.httpBody))")
            // myActivityIndicator.startAnimating();
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                // You can print out response object
                print("******* response = \(String(describing: response))")
                
                // Print out reponse body
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")
                
                
                let respVO:[RespVo] = Mapper<RespVo>().mapArray(JSONString: responseString! as String)!
                
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
                        self.dismiss(animated: false, completion: nil)
                        
                        
                        self.uploadClientTxtField.text = ""
                        self.uploadCaseTxtField.text = ""
                        self.uploadSubsidairyTxtField.text = ""
                        
                        self.uploadImageView.image = UIImage (named: "upload")
                        self.fileNameLabel.text = "FILE NAME"
                        self.hideLabel.isHidden = false
                        
                        
                    })
                    
                    
                }
                
            }
            
            task.resume()
        }
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = Data();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        
        
        //let newObj = "manu.jpg"
        //let manuObj = fileNameLabel.text
        body.appendString(string: "--\(boundary)\r\n")
        
        let mimetype = "image/jpg"
        
        //let defFileName = fileNameObj
        
        
        
        let imageData = UIImageJPEGRepresentation(uploadImageView.image!, 1)
        print("defFileName is :\(String(describing: imageData))")
        
        let fnamed = fileNameLabel.text
        print("fnamed is:\(fnamed!)")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fnamed!)\"\r\n")
        
        print("njsc is:\( body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fnamed!)\"\r\n"))")
        
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData!)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
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
    func  postMethodUploadCase() {
        
        let clientID:String = String(clientIdIndex)
        print("clientId is:\(clientID)")
        
        let masterClientIdObj:String = String(masterIdStored)
        
        
        let json = ["clientId":clientID,"masterClientId":masterClientIdObj] as [String : Any]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        var request = URLRequest(url: URL(string: "http://digilegal.neviton.com:8080/Legal-app/getCaseList")!)
        request.httpMethod = "POST"
        
        let postData:NSData?  =  jsonData as NSData?
        
        
        let postLength:NSString = NSString(format:"%d",postData!.length)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.httpBody = postData as Data?
        
        //        request.httpBody = body.data(using: .max)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let alert = UIAlertView(title: "Error", message: "Could not connect to the server check your wifi or mobile data", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    self.dismiss(animated: false, completion: nil)
                })
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                self.dismiss(animated: false, completion: nil)
            }
            
            
            let responseString = String(data: data, encoding: .utf8)
            
            
            print("responseString = \(responseString)")
            
            let respVO:[SubDownloadRespVo] = Mapper<SubDownloadRespVo>().mapArray(JSONString: responseString!)!
            
            print("responseString = \(respVO)")
            
            
            
            for (index, element) in (respVO.enumerated()) {
                print("Item \(index): \(element)")
                
                
                self.uploadCaseListArr.append(element.caseType!)
                
                //                    = [element.subClientName! as String]
                self.uploadCaseIdObj.append(element.caseId!)
                
                
            }
            
            //            print("subsidiaryidObj is:\(self.subsidiaryIdObj)")
            //            print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
            //
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.uploadCaseTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
}


//    extension Data {
//        mutating func appendString(string: String) {
//            append(string.data(using: .utf8)!)
//        }
//}


