//
//  HomeViewController.swift
//  DIGI-LEGAL
//
//  Created by srikanth on 10/3/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit


//struct MyVariables {
//    static var associateId = "1095"
//    static var associateName = "Vivek Shivakumar"
//    static var masterClientId = "101"
//
//}


class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet var clientTxtField: NoCopyPasteUITextField!
    @IBOutlet var clientTableView: UITableView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var activityTableView: UITableView!
    // @IBOutlet var associateTableView: UITableView!
    @IBOutlet var caseTableView: UITableView!
    
    var associateId:Int!
    var associateName:String!
    var masterClientId:Int!
    
    @IBOutlet var subsidiaryTableView: UITableView!
    @IBOutlet var associateTxtField: NoCopyPasteUITextField!
    @IBOutlet var activityTxtField: NoCopyPasteUITextField!
    @IBOutlet var caseTxtField: NoCopyPasteUITextField!
    @IBOutlet var toDateTxtField: NoCopyPasteUITextField!
    @IBOutlet var fromDateTxtField: NoCopyPasteUITextField!
    @IBOutlet var subsidiaryTxtField: NoCopyPasteUITextField!
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    @IBOutlet var cancelBtn: UIButton!
    
    var dataTask:URLSessionDataTask?
    
    
    var fromDate = UIDatePicker()
    var toDate = UIDatePicker()
    
    
    
    var clientIdIndex:Int!
    var caseIdIndex:Int!
    var activityIndex:Int!
    var subsidiaryIndex:Int!
    
    
    
    
    var clientListArr = [String]()
    var clientIdObj = [Int]()
    
    var subsidiaryNameArr = [String]()
    var subsidiaryIdObj = [Int]()
    
    var caseListArr = [String]()
    var caseIdObj = [Int]()
    
    var associateListArr = [String]()
    var associateIdObj = [Int]()
    
    var activityListArr = [String]()
    var activityIdObj = [Int]()
    
    var associateStored:Int!
    var masterIdStored:Int!
    var associateNameStored:String!
    
    var fromDateObj:String!
    var toDateObj:String!
    
    
    
    let cellReuseIdentifier = "cell"
    let subsidiaryCellidentifier = "cell1"
    let caseCellIdentifier = "cell2"
    let associateCellIdentifier = "cell3"
    let activityCellIdentifier = "cell4"
    
    // final let urlString = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        associateStored =  UserDefaults.standard.integer(forKey: "key1")
        
        masterIdStored =  UserDefaults.standard.integer(forKey: "key2")
        associateNameStored =  UserDefaults.standard.string(forKey: "key3")
        
        
        print("associateStored is :\(associateStored)")
        print("masterIdStored is :\(masterIdStored)")
        
        print("associateNameStored is :\(associateNameStored)")
        
        
        
        
        
        // print(value)
        
        
        clientTxtField.layer.borderColor = UIColor.gray.cgColor
        clientTxtField.layer.borderWidth = 1.0
        clientTxtField.layer.cornerRadius = 5
        clientTxtField.layer.masksToBounds = false
        
        subsidiaryTxtField.layer.borderColor = UIColor.gray.cgColor
        subsidiaryTxtField.layer.borderWidth = 1.0
        subsidiaryTxtField.layer.cornerRadius = 5
        subsidiaryTxtField.layer.masksToBounds = false
        
        caseTxtField.layer.borderColor = UIColor.gray.cgColor
        caseTxtField.layer.borderWidth = 1.0
        caseTxtField.layer.cornerRadius = 5
        caseTxtField.layer.masksToBounds = false
        
        associateTxtField.layer.borderColor = UIColor.gray.cgColor
        associateTxtField.layer.borderWidth = 1.0
        associateTxtField.layer.cornerRadius = 5
        associateTxtField.layer.masksToBounds = false
        
        activityTxtField.layer.borderColor = UIColor.gray.cgColor
        activityTxtField.layer.borderWidth = 1.0
        activityTxtField.layer.cornerRadius = 5
        activityTxtField.layer.masksToBounds = false
        
        
        
        
        addBtn.layer.cornerRadius = 5
        addBtn.clipsToBounds = true
        
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.clipsToBounds = true
        
        self.navigationItem.title = "NEXT ACTIVITIES"
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        
        self.associateTxtField.text = (associateNameStored)
        self.associateTxtField.isUserInteractionEnabled = false
        
        self.clientTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.subsidiaryTableView.register(UITableViewCell.self, forCellReuseIdentifier: subsidiaryCellidentifier)
        self.caseTableView.register(UITableViewCell.self, forCellReuseIdentifier: caseCellIdentifier)
        //self.associateTableView.register(UITableViewCell.self, forCellReuseIdentifier: associateCellIdentifier)
        self.activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: activityCellIdentifier)
        
        clientTableView.layer.cornerRadius = 10
        clientTableView.isHidden = true
        subsidiaryTableView.layer.cornerRadius = 10
        subsidiaryTableView.isHidden = true
        caseTableView.layer.cornerRadius = 10
        caseTableView.isHidden = true
        // associateTableView.layer.cornerRadius = 10
        // associateTableView.isHidden = true
        activityTableView.layer.cornerRadius = 10
        activityTableView.isHidden = true
        
        clientTxtField.addTarget(self, action: #selector(textFieldActive), for: UIControlEvents.touchDown)
        subsidiaryTxtField.addTarget(self, action: #selector(subsidiaryFieldActive), for: UIControlEvents.touchDown)
        
        caseTxtField.addTarget(self, action: #selector(caseFieldActive), for: UIControlEvents.touchDown)
        
        associateTxtField.addTarget(self, action: #selector(associateFieldActive), for: UIControlEvents.touchDown)
        
        activityTxtField.addTarget(self, action: #selector(activityFieldActive), for: UIControlEvents.touchDown)
        toDateTxtField.addTarget(self, action: #selector(createToDatepicker), for: UIControlEvents.touchDown)
        fromDateTxtField.addTarget(self, action: #selector(createFromDatepicker), for: UIControlEvents.touchDown)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        self.createFromDatepicker()
        self.createToDatepicker()
        self.fetchSelectClients()
        self.fetchSelectActivity()
        
    }
    
    
    
    
    func createFromDatepicker()   {
        //formate of date
        fromDate.datePickerMode = .dateAndTime
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //barbuttomitem
        let donebuttom = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonepressedFromDate))
        toolbar.setItems([donebuttom], animated: false)
        fromDateTxtField.inputAccessoryView = toolbar
        //assgin datepicker to text field
        fromDateTxtField.inputView = fromDate
        fromDate.minimumDate = Date()
        //timepickeroutlet.isUserInteractionEnabled = false
    }
    func createToDatepicker()   {
        //formate of date
        toDate.datePickerMode = .dateAndTime
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //barbuttomitem
        let donebuttom = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonepressedToDate))
        toolbar.setItems([donebuttom], animated: false)
        toDateTxtField.inputAccessoryView = toolbar
        //assgin datepicker to text field
        toDateTxtField.inputView = fromDate
        fromDate.minimumDate = fromDate.date
        //timepickeroutlet.isUserInteractionEnabled = false
    }
    
    func DonepressedFromDate()  {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy h:mm a "
        dateformatter.amSymbol = "AM"
        dateformatter.pmSymbol = "PM"
        fromDateTxtField.text = dateformatter.string(from: fromDate.date)
        let dateConvert = fromDateTxtField.text
        print("date is:\(String(describing: dateConvert))")
        
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
        fromDateObj = dateformatter.string(from: fromDate.date)
        
        UserDefaults.standard.set(fromDateObj, forKey: "key4")
        
        
        print("fromDateObj is:\(fromDateObj)")
        self.view.endEditing(true)
    }
    
    
    
    
    func DonepressedToDate()  {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy h:mm a "
        dateformatter.amSymbol = "AM"
        dateformatter.pmSymbol = "PM"
        toDateTxtField.text = dateformatter.string(from: fromDate.date)
        
        let dateConvert = toDateTxtField.text
        print("ToDate is:\(String(describing: dateConvert))")
        
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
        toDateObj = dateformatter.string(from: fromDate.date)
        
        UserDefaults.standard.set(toDateObj, forKey: "key5")
        
        print("manuObjToDate is:\(toDateObj)")
        
        
        self.view.endEditing(true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        //         self.view.endEditing(true)
        
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != clientTableView
        {
            clientTxtField.endEditing(true)
            clientTableView.isHidden = true
        }
        if touch.view != subsidiaryTableView
        {
            
            subsidiaryTxtField.endEditing(true)
            subsidiaryTableView.isHidden = true
        }
        
        if touch.view != caseTableView
        {
            caseTxtField.endEditing(true)
            caseTableView.isHidden = true
        }
        
        
        if touch.view != activityTableView
        {
            activityTxtField.endEditing(true)
            activityTableView.isHidden = true
        }
        
        
        
    }
    func textFieldActive() {
        
        //        DispatchQueue.main.async(execute: { () -> Void in
        
        //             self.tableView.isHidden = !self.tableView.isHidden
        //        self.fetchAutocompletePlaces()
        //clientTableView.isHidden = true
        subsidiaryTableView.isHidden = true
        caseTableView.isHidden = true
        // associateTableView.isHidden = true
        activityTableView.isHidden = true
        
        if clientTableView.isHidden {
            
            clientTableView.isHidden = false
            
        }
        else{
            
            clientTableView.isHidden = true
            
        }
        
        //            self.fetchAutocompletePlaces()
        //        })
        
        
        //        self.tableView.reloadData()
        
        
    }
    
    func subsidiaryFieldActive() {
        
        clientTableView.isHidden = true
        caseTableView.isHidden = true
        // associateTableView.isHidden = true
        activityTableView.isHidden = true
        subsidiaryTableView.isHidden = !subsidiaryTableView.isHidden
        
    }
    
    func caseFieldActive() {
        
        clientTableView.isHidden = true
        subsidiaryTableView.isHidden = true
        //associateTableView.isHidden = true
        activityTableView.isHidden = true
        caseTableView.isHidden = !caseTableView.isHidden
        
    }
    func associateFieldActive() {
        
        clientTableView.isHidden = true
        subsidiaryTableView.isHidden = true
        caseTableView.isHidden = true
        activityTableView.isHidden = true
        // associateTableView.isHidden = !associateTableView.isHidden
        
    }
    func activityFieldActive() {
        
        clientTableView.isHidden = true
        subsidiaryTableView.isHidden = true
        caseTableView.isHidden = true
        // associateTableView.isHidden = true
        activityTableView.isHidden = !activityTableView.isHidden
        
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
        if textField == subsidiaryTxtField{
            if (clientTxtField.text?.isEmpty)!{
                self.Displaymyalertmessage(usermessage: "Please Select Client Field First")
                subsidiaryTableView.isHidden = true
            }
            
        }
        
        if textField == self.clientTxtField
            
        {
            
            self.caseTxtField.text = ""
        }
        
        return false //do not show keyboard nor cursor
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.clientTableView {
            count = clientListArr.count
        }
        if tableView == self.subsidiaryTableView {
            count = subsidiaryNameArr.count
        }
        if tableView == self.caseTableView {
            count =  caseListArr.count
        }
        
        //        if tableView == self.associateTableView {
        //            count =  associateListArr.count
        //        }
        
        if tableView == self.activityTableView {
            count =  activityListArr.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        var cell:UITableViewCell?
        
        // Set text from the data model
        
        if tableView == self.clientTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = clientListArr[indexPath.row]
            cell?.textLabel?.font = clientTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        if tableView == self.subsidiaryTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell?.textLabel?.text = subsidiaryNameArr[indexPath.row]
            cell?.textLabel?.font = subsidiaryTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        if tableView == self.caseTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell?.textLabel?.text = caseListArr[indexPath.row]
            cell?.textLabel?.font = caseTxtField.font
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //            cell?.backgroundColor = UIColor.lightText
            cell?.layer.cornerRadius = 10.0
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        //        if tableView == self.associateTableView {
        //            cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        //            cell?.textLabel?.text = associateListArr[indexPath.row]
        //            cell?.textLabel?.font = associateTxtField.font
        //            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        //            //            cell?.backgroundColor = UIColor.lightText
        //            cell?.layer.cornerRadius = 10.0
        //            cell?.backgroundColor = UIColor.darkGray
        //            cell?.textLabel?.textColor = UIColor.white
        //            cell?.selectionStyle = .none
        //            //            cell?.selectionStyle = UITableViewCellSelectionStyle.blue
        //            //            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        //
        //        }
        if tableView == self.activityTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            cell?.textLabel?.text = activityListArr[indexPath.row]
            cell?.textLabel?.font = activityTxtField.font
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
        
        if tableView == self.clientTableView {
            
            clientTxtField.text = clientListArr[indexPath.row]
            
            self.clientIdIndex = clientIdObj[indexPath.row]
            
            self.caseListArr.removeAll()
            self.postMethodSubsidiary()
            self.fetchSelectCases()
            
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            clientTableView.isHidden = true
            clientTxtField.endEditing(true)
            
        }
        if tableView == self.subsidiaryTableView {
            
            subsidiaryTxtField.text = subsidiaryNameArr[indexPath.row]
            
            self.subsidiaryIndex = subsidiaryIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            subsidiaryTableView.isHidden = true
            subsidiaryTxtField.endEditing(true)
            
        }
        if tableView == self.caseTableView {
            
            caseTxtField.text = caseListArr[indexPath.row]
            
            self.caseIdIndex = caseIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            caseTableView.isHidden = true
            caseTxtField.endEditing(true)
            
        }
        //        if tableView == self.associateTableView {
        //
        //            associateTxtField.text = associateListArr[indexPath.row]
        //
        //            //self.clientIdIndex = clientIdObj[indexPath.row]
        //
        //            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
        //
        //            associateTableView.isHidden = true
        //            associateTxtField.endEditing(true)
        //
        //        }
        if tableView == self.activityTableView {
            
            activityTxtField.text = activityListArr[indexPath.row]
            
            self.activityIndex = activityIdObj[indexPath.row]
            
            //             print("clientIdIndex:\(self.clientIdIndex as Int)")
            
            activityTableView.isHidden = true
            activityTxtField.endEditing(true)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        if clientTxtField.text == ""
        {
            
            Displaymyalertmessage(usermessage:"Please Select Client")
            return
        }
        
        if caseTxtField.text == ""
        {
            
            Displaymyalertmessage(usermessage:"Please Select Case")
            return
        }
        
        
        //self.subsidiaryTxtField.text = MyVariables.sunsidiaryId
        // print("subsidiaryTxtField is :\(MyVariables.sunsidiaryId)")
        
        
        
        
        if activityTxtField.text == ""
        {
            
            self.Displaymyalertmessage(usermessage:"Please Select Activity")
            return
        }
        if fromDateTxtField.text == ""
        {
            
            self.Displaymyalertmessage(usermessage:"Please Select From Date & Time")
            return
        }
        
        if toDateTxtField.text == ""
        {
            
            self.Displaymyalertmessage(usermessage:"Please Select To Date & Time")
            return
        }
            
        else
        {
            let clientID:String = String(clientIdIndex)
            let caseID:String = String(caseIdIndex)
            let activityID:String = String(activityIndex)
            let associateID:String = String(associateStored)
            let fromDateObj:String = UserDefaults.standard.string(forKey: "key4")!
            
            let toDateObj:String =  UserDefaults.standard.string(forKey: "key5")!
            let subId:String = String(MyVariables.sunsidiaryId)
            
            
            print("clientID:\(clientID)")
            print("caseID:\(caseID)")
            print("activityID:\(activityID)")
            print("caseID:\(associateID)")
            print("dateObj:\(fromDateObj)")
            print("timeObj:\(toDateObj)")
            print("subid:\(subId)")
            
            
            let json = [ "client":clientID,"associate":associateID,"activities":activityID,"caseID":caseID,"nextActivityDate":fromDateObj,"nextActivityDateTo":toDateObj,"idSubClient":subId] as [String : Any]
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            
            print("json is:\(json)")
            
            var request = URLRequest(url: URL(string:"http://digilegal.neviton.com:8080/Legal-app/addNextAct")!)
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
                
                
                let respVO:[RespVo] = Mapper<RespVo>().mapArray(JSONString: responseString!)!
                
                print("responseString = \(respVO)")
                
                let successResp = respVO[0].response
                
                
                
                let statusResp = "Record Added Successfully"
                
                
                if successResp == statusResp {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        //                    self.submitOutlet.isUserInteractionEnabled = false
                        
                        
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
                        
                        ViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        
                        self.addChildViewController(ViewController)
                        self.view.addSubview(ViewController.view)
                        
                        self.clientTxtField.text = ""
                        self.subsidiaryTxtField.text = ""
                        self.caseTxtField.text = ""
                        // self.associateTxtField.text = ""
                        self.activityTxtField.text = ""
                        self.fromDateTxtField.text = ""
                        self.toDateTxtField.text = ""
                        
                        self.dismiss(animated: false, completion: nil)
                        
                    })
                    
                    
                }
                else {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        let alert = UIAlertView(title: "Error", message: "The Associate is already being locked for next 1 hour from the provided time Kindly schedule your meeting after 1 hour", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                        self.dismiss(animated: false, completion: nil)
                        
                    })
                    
                }
                
                
            }
            task.resume()
            
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
                            
                            
                            self.clientListArr.append(element["clientName"] as! String)
                            
                            self.clientIdObj.append(element["clientId"] as! Int)
                            
                            
                            
                            //                                print("clientNameList:\(self.clientIdObj)")
                            
                            
                        }
                        
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.clientTableView.reloadData()
                            
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
    
    
    
    
    
    //    func fetchSelectCases() {
    //
    //        let urlString = "http://digilegal.neviton.com:8080/Legal-app/getCaseList"
    //
    //        if let url = URL(string: urlString) {
    //
    //            let request = URLRequest(url: url)
    //
    //            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
    //                if let data = data{
    //
    //                    do{
    //
    //                        let result = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
    //
    //                        for (index, element) in (result.enumerated()) {
    //                            print("Item \(index): \(element)")
    //
    //
    //                            self.caseListArr.append(element["caseType"] as! String)
    //
    //                            self.caseIdObj.append(element["caseId"] as! Int)
    //
    //                            //                            print("caseList:\(self.caseList)")
    //
    //
    //                        }
    //
    //                        DispatchQueue.main.async(execute: { () -> Void in
    //
    //                            self.caseTableView.reloadData()
    //                        })
    //                    }
    //                    catch let error as NSError{
    //                        print("Error: \(error.localizedDescription)")
    //                    }
    //                }
    //            })
    //            dataTask?.resume()
    //        }
    //    }
    
    func fetchSelectActivity() {
        
        let urlString = "http://digilegal.neviton.com:8080/Legal-app/getActivityList"
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let data = data{
                    
                    do{
                        
                        let result = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
                        
                        for (index, element) in (result.enumerated()) {
                            print("Item \(index): \(element)")
                            
                            
                            self.activityListArr.append((element["nameActivity"] as? String)!)
                            self.activityIdObj.append(element["activityId"] as! Int)
                            
                            self.associateIdObj.append(element["associateId"] as! Int)
                            
                            //                            print("activityList:\(self.activityList)")
                            
                            
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.activityTableView.reloadData()
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
                
                
                self.subsidiaryNameArr.append(element.subClientName!)
                
                //                    = [element.subClientName! as String]
                self.subsidiaryIdObj.append(element.subClientId!)
                
                
            }
            
            
            print("subsidiaryidObj is:\(self.subsidiaryIdObj)")
            print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.subsidiaryTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        
        self.clientTxtField.text = ""
        self.subsidiaryTxtField.text = ""
        self.caseTxtField.text = ""
        self.activityTxtField.text = ""
        self.fromDateTxtField.text = ""
        self.toDateTxtField.text = ""
    }
    
    func Displaymyalertmessage(usermessage:String)
    {
        
        let  myalert = UIAlertController(title: "", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
        
    }
    
    
    func fetchSelectCases()
    {
        
        let clientID:String = String(clientIdIndex)
        print("clientId is:\(clientID)")
        let masterClientId:String = String(masterIdStored)
        
        let json = ["clientId":clientID,"masterClientId":masterClientId] as [String : Any]
        
        print("json is:\(json)")
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
                
                
                self.caseListArr.append(element.caseType!)
                self.caseIdObj.append(element.caseId!)
                
                
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.caseTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    
    
    
    
    
}


