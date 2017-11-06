//
//  DownloadCaseViewController.swift
//  DIGI-LEGAL
//
//  Created by Apple on 04/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit

class DownloadCaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate
    
{
    @IBOutlet var downloadClientTxtFiled: NoCopyPasteUITextField!
    
    @IBOutlet var downloadSubsidiaryTxtField: NoCopyPasteUITextField!
    @IBOutlet var downloadCaseTxtFiled: NoCopyPasteUITextField!
    @IBOutlet var dataDisplayTableview: UITableView!
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    @IBOutlet var downloadClientTableView: UITableView!
    
    @IBOutlet var downloadCaseTableView: UITableView!
    @IBOutlet var downloadSubsidiaryTableView: UITableView!
    
    var dataTask:URLSessionDataTask?
    
    var actualFileName = [String]()
    var storedName:String = ""
    
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    
    
    
    
    
    var downloadClientListArr = [String]()
    var downloadClientIdObj = [Int]()
    
    var downloadCaseListArr = [String]()
    var downloadCaseIdObj = [Int]()
    
    var downloadSubsidiaryListArr = [String]()
    var downloadSubsidiaryIdObj = [Int]()
    
    var fileNameObjShow = [String]()
    var dtUplObjShow = [String]()
    var uploaderNameObjShow = [String]()
    var clientNameObjShow = [String]()
    var caseNameObjShow = [String]()
    
    
    
    let cellReuseIdentifier = "cell"
    let caseCellIdentifier = "cell1"
    let subsidiaryCellidentifier = "cell2"
    
    
    var clientIdIndex:Int!
    var caseIdIndex:Int!
    var subsidiaryIndex:Int!
    
    var associateStored:Int!
    var masterIdStored:Int!
    var associateNameStored:String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadCaseTxtFiled.text = "All"
        
        
        associateStored =  UserDefaults.standard.integer(forKey: "key1")
        
        masterIdStored =  UserDefaults.standard.integer(forKey: "key2")
        associateNameStored =  UserDefaults.standard.string(forKey: "key3")
        
        print("associateStored is :\(associateStored)")
        print("masterIdStored is :\(masterIdStored)")
        
        print("associateNameStored is :\(associateNameStored)")
        
        
        
        
        self.navigationItem.title = "CASE RELATED DOCUMENTS"
        
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        self.downloadClientTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.downloadCaseTableView.register(UITableViewCell.self, forCellReuseIdentifier: caseCellIdentifier)
        
        self.downloadSubsidiaryTableView.register(UITableViewCell.self, forCellReuseIdentifier: subsidiaryCellidentifier)
        
        downloadClientTableView.layer.cornerRadius = 10
        downloadClientTableView.isHidden = true
        downloadCaseTableView.layer.cornerRadius = 10
        downloadCaseTableView.isHidden = true
        downloadSubsidiaryTableView.layer.cornerRadius = 10
        downloadSubsidiaryTableView.isHidden = true
        
        downloadClientTxtFiled.addTarget(self, action: #selector(textFieldActive), for: UIControlEvents.touchDown)
        downloadCaseTxtFiled.addTarget(self, action: #selector(caseFieldActive), for: UIControlEvents.touchDown)
        downloadSubsidiaryTxtField.addTarget(self, action: #selector(subsidiaryFieldActive), for: UIControlEvents.touchDown)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.fetchSelectClients()
        self.fetchSelectCases()
        self.fetchGeneralDoc()
        
        
        
        // Do any additional setup after loading the view.
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
        
        
        if textField == downloadSubsidiaryTxtField{
            
            dataDisplayTableview.isHidden = true
            
            if (downloadClientTxtFiled.text?.isEmpty)!{
                self.Displaymyalertmessage(usermessage: "Please Select Client Field First")
                
                downloadSubsidiaryTableView.isHidden = true
            }
        }
        
        
        if textField == downloadClientTxtFiled {
            
            self.downloadCaseTxtFiled.text = "All"
            
            if (downloadClientTxtFiled.text != ""){
                
                dataDisplayTableview.isHidden = true
            }
        }
        if textField == downloadCaseTxtFiled {
            
            if (downloadCaseTxtFiled.text != ""){
                
                dataDisplayTableview.isHidden = true
            }
        }
        
        
        
        
        return false //do not show keyboard nor cursor
    }
    
    
    func subsidiaryFieldActive() {
        
        downloadClientTableView.isHidden = true
        downloadCaseTableView.isHidden = true
        downloadSubsidiaryTableView.isHidden = !downloadSubsidiaryTableView.isHidden
        
    }
    
    func caseFieldActive() {
        
        downloadClientTableView.isHidden = true
        downloadSubsidiaryTableView.isHidden = true
        downloadCaseTableView.isHidden = !downloadCaseTableView.isHidden
        
    }
    
    
    func textFieldActive() {
        
        //        DispatchQueue.main.async(execute: { () -> Void in
        
        //             self.tableView.isHidden = !self.tableView.isHidden
        //        self.fetchAutocompletePlaces()
        //clientTableView.isHidden = true
        downloadSubsidiaryTableView.isHidden = true
        downloadCaseTableView.isHidden = true
        
        downloadClientTableView.isHidden = true
        
        if downloadClientTableView.isHidden {
            
            downloadClientTableView.isHidden = false
            
        }
        else{
            
            downloadClientTableView.isHidden = true
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        
        if tableView == downloadClientTableView
        {
            count =  downloadClientListArr.count
        }
        if tableView == downloadCaseTableView
        {
            count =  downloadCaseListArr.count
        }
        if tableView == downloadSubsidiaryTableView
        {
            count =  downloadSubsidiaryListArr.count
        }
        if tableView == dataDisplayTableview
        {
            count = fileNameObjShow.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell?
        
        // Set text from the data model
        
        
        if tableView == downloadClientTableView
            
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = downloadClientListArr[indexPath.row]
            cell?.textLabel?.font = downloadClientTxtFiled.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            
            
            
            
        }
        
        
        
        if tableView == downloadCaseTableView
            
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell?.textLabel?.text = downloadCaseListArr[indexPath.row]
            cell?.textLabel?.font = downloadCaseTxtFiled.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            
            
        }
        
        
        if tableView == downloadSubsidiaryTableView
            
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell?.textLabel?.text = downloadSubsidiaryListArr[indexPath.row]
            cell?.textLabel?.font = downloadSubsidiaryTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            
            
        }
        
        if tableView == dataDisplayTableview
            
        {
            
            let cell = dataDisplayTableview.dequeueReusableCell(withIdentifier: "DownloadCaseTableViewCell", for: indexPath) as! DownloadCaseTableViewCell
            
            cell.fileNameLabel.text = fileNameObjShow[indexPath.row]
            cell.adminNameLabel.text = uploaderNameObjShow[indexPath.row]
            cell.clientNameLabel.text = clientNameObjShow[indexPath.row]
            cell.caseNameLabel.text = caseNameObjShow[indexPath.row]
            cell.dateLabel.text = dtUplObjShow[indexPath.row]
            
            // cell.performTask.addTarget(self, action: #selector(buttonPressed(_:)), for: UIControlEvents.touchUpInside)
            
            
            return cell
        }
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        
        if tableView == self.downloadClientTableView {
            
            downloadClientTxtFiled.text = downloadClientListArr[indexPath.row]
            
            self.clientIdIndex = downloadClientIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            //dataDisplayTableview.isHidden = false
            
            self.downloadCaseListArr.removeAll()
            
            self.postMethodCase()
            
            downloadClientTableView.isHidden = true
            downloadClientTxtFiled.endEditing(true)
            
            self.postMethodSubsidiary()
            
            
        }
        
        if tableView == self.downloadSubsidiaryTableView {
            
            downloadSubsidiaryTxtField.text = downloadSubsidiaryListArr[indexPath.row]
            
            self.subsidiaryIndex = downloadSubsidiaryIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            downloadSubsidiaryTableView.isHidden = true
            downloadSubsidiaryTxtField.endEditing(true)
            
        }
        if tableView == self.downloadCaseTableView {
            
            downloadCaseTxtFiled.text = downloadCaseListArr[indexPath.row]
            
            self.caseIdIndex = downloadCaseIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            //dataDisplayTableview.isHidden = false
            downloadCaseTableView.isHidden = true
            downloadCaseTxtFiled.endEditing(true)
            
        }
        
        
        if tableView == self.dataDisplayTableview
            
        {
            
            
            
            
            let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
            backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
            
            
            
            storedName = actualFileName[indexPath.row]
            
            
            print("name is thatt :\(storedName)")
            
            let url = URL(string: "http://digilegal.neviton.com:8080/Legal-app/rest/download/101/\(storedName)")
            
            if url == nil
            {
                print("url is empty")
            }
                
            else{
                
                
                self.downloadTask = self.backgroundSession.downloadTask(with: (url)!)
                self.downloadTask.resume()
                
            }
            
            
        }
        
        
        
        
        
        
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
                            
                            
                            self.downloadClientListArr.append(element["clientName"] as! String)
                            
                            self.downloadClientIdObj.append(element["clientId"] as! Int)
                            
                            //                                print("clientNameList:\(self.clientIdObj)")
                            
                            
                        }
                        
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.downloadClientTableView.reloadData()
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
    
    
    
    func fetchGeneralDoc() {
        
        let urlString = "http://digilegal.neviton.com:8080/Legal-app/retrieveGenDoc/101"
        
        
        let url  = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(Data,URLResponse,Error) -> Void in
            
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as? NSDictionary
            {
                //print(jsonObj!.value(forKey: "actors"))
                
                if let actorArray = jsonObj!.value(forKey: "response") as? NSArray
                {
                    for actor in actorArray
                    {
                        
                        if let actorDict = actor as? NSDictionary
                        {
                            
                            
                            
                            
                            if let actualfileName = actorDict.value(forKey: "actualFileName")
                                
                            {
                                self.actualFileName.append(actualfileName as! String)
                            }
                            
                        }
                    }
                }
                
            }
        }).resume()
        
        
        
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
                            
                            
                            self.downloadCaseListArr.append(element["caseType"] as! String)
                            
                            self.downloadCaseIdObj.append(element["caseId"] as! Int)
                            
                            //                            print("caseList:\(self.caseList)")
                            
                            
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.downloadCaseTableView.reloadData()
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
    
    func  postMethodSubsidiary() {
        
        let clientID:String = String(clientIdIndex)
        print("clientId is:\(clientID)")
        
        let json = ["client":clientID] as [String : Any]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        
        //    let obj = "jesuschrist"
        //
        //        let body: NSString = NSString(format:"{\"message\":%@}", obj)
        
        var request = URLRequest(url: URL(string:"http://digilegal.neviton.com:8080/Legal-app/getSubClientList")!)
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
                
                
                self.downloadSubsidiaryListArr.append(element.subClientName!)
                
                //                    = [element.subClientName! as String]
                self.downloadSubsidiaryIdObj.append(element.subClientId!)
                
                
            }
            
            
            //            self.subsidiaryIdObj  = [respVO[0].subClientId!]
            //             self.subsidiaryNameArr  = [respVO[0].subClientName!]
            //
            //            self.subsidiaryIdObj  = [respVO[1].subClientId!]
            //            self.subsidiaryNameArr  = [respVO[1].subClientName!]
            
            print("subsidiaryidObj is:\(self.subsidiaryIndex)")
            //print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.downloadSubsidiaryTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
    
    @IBAction func showFilesActionTapped(_ sender: Any) {
        
        
        if downloadClientTxtFiled.text == ""
        {
            
            clientIdIndex = 1
            //self.Displaymyalertmessage(usermessage:"Please select the ClientName")
           // return
        }
       if downloadCaseTxtFiled.text == "All"
        {
            // self.Displaymyalertmessage(usermessage:"Please select the Case")
            // return
            
            self.downloadCaseTxtFiled.text = "All"
            caseIdIndex = 1
            
            
        }
        
        
        //        if downloadSubsidiaryTxtField.text == ""
        //        {
        //        self.Displaymyalertmessage(usermessage:"Please select the Subsidiary")
        //        }
        
        
        else
        {
            
            
            //dataDisplayTableview.isHidden = false
            
            let clientID:String = String(clientIdIndex)
            let caseID:String = String(caseIdIndex)
            let masterClientIdObj:String = String(masterIdStored)
            
            
            print("clientID:\(clientID)")
            print("caseID:\(caseID)")
            // print("subid:\(subId)")
            
            
            let json = ["clientId":clientID,"caseId":caseID,"masterClientId":masterClientIdObj] as [String : Any]
            
            print("json is:\(json)")
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            
            //    let obj = "jesuschrist"
            //
            //        let body: NSString = NSString(format:"{\"message\":%@}", obj)
            
            var request = URLRequest(url: URL(string: "http://digilegal.neviton.com:8080/Legal-app/retrieveCaseDoc")!)
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
                print("responseString = \(String(describing: responseString))")
                
                
                
                let respGroupEventVO:DownloadShowFilesRespVo = Mapper().map(JSONString: responseString!)!
                
                let errorResponse = "NO documents For this case. Please select a document and click on upload to upload documents for this case."
                
                
                
                print("respGroupEventVO:\(String(describing: respGroupEventVO.response))")
                
                let respObj = respGroupEventVO.response
                let failObj = respGroupEventVO.error
                
                // let failObj = "{\"response\":\"NO documents For this case. Please select a document and click on upload to upload documents for this case.\"}"
                
                if errorResponse == failObj {
                    
                    
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        let alert = UIAlertView(title: "Error", message: "NO documents For this case. Please select a document and click on upload to upload documents for this case.", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                        self.dismiss(animated: false, completion: nil)
                    })
                    
                    
                    
                }
                else {
                    
                    for actor in respObj! {
                        
                        if let name = actor.fileName {
                            self.fileNameObjShow.append(name)
                        }
                        if let name = actor.uploaderName {
                            self.uploaderNameObjShow.append(name)
                        }
                        if let name = actor.clientName {
                            self.clientNameObjShow.append(name)
                        }
                        if let name = actor.caseName {
                            self.caseNameObjShow.append(name)
                        }
                        if let name = actor.dtUpl {
                            self.dtUplObjShow.append(name)
                        }
                        
                        
                        //print("resObj is:\(String(describing: resObj))")
                        print("fileNameObjShow is:\(String(describing:self.fileNameObjShow))")
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.dataDisplayTableview.isHidden = false
                            self.dataDisplayTableview.reloadData()
                            
                        })
                    }
                }
                
            };task.resume()
            
        }
    }
    
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/\(storedName)"))
        
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            showFileWithPath(path: destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                // show file
                showFileWithPath(path: destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreview(animated: true)
        }
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?){
        downloadTask = nil
        // progressView.setProgress(0.0, animated: true)
        if (error != nil) {
            print(error!.localizedDescription)
        }else{
            print("The task finished transferring data successfully")
        }
    }
    
    
    
    
    
    func Displaymyalertmessage(usermessage:String)
    {
        
        let  myalert = UIAlertController(title: "Alert", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
        
    }
    
    
    func  postMethodCase() {
        
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
                
                
                self.downloadCaseListArr.append(element.caseType!)
                
                //                    = [element.subClientName! as String]
                self.downloadCaseIdObj.append(element.caseId!)
                
                
            }
            
            //            print("subsidiaryidObj is:\(self.subsidiaryIdObj)")
            //            print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
            //
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.downloadCaseTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
    
    
    
}
