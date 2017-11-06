//
//  ViewController.swift
//  BillLegalApp
//
//  Created by Apple on 17/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import UIKit


struct MyVariables {

    static var sunsidiaryId = "0"
    
    
}

class MyTimeCardsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var textField: NoCopyPasteUITextField!
    
    @IBOutlet weak var caseTextfield: NoCopyPasteUITextField!
    
    @IBOutlet weak var activityField: NoCopyPasteUITextField!
    
    @IBOutlet weak var dateField: NoCopyPasteUITextField!
    
    @IBOutlet weak var timeField: NoCopyPasteUITextField!
    
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightActivity: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var caseTableView: UITableView!
    
    @IBOutlet weak var heightCase: NSLayoutConstraint!

    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var timeTableView: UITableView!
    
    @IBOutlet weak var heightTime: NSLayoutConstraint!
    
   // var associatId:Int?
    
    @IBOutlet weak var otherExpField: UITextView!
    
    
    @IBOutlet var submitOutlet: UIButton!
    
    @IBOutlet var clientLabel:UILabel!
    
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    var fromDate = UIDatePicker()

    
    var associateId:Int!
    var associateName:String!
    var masterClientId:Int!
    var subsidiaryId:Int!

    var timeList = ["15","30","45","60","90","120","180","Others"]
    
    let cellReuseIdentifier = "cell"
    let cellidentifier = "cell1"
    let activityIdentifier = "cell2"
    let timeIdentifier = "cell3"
    
    var clientNameList = [String]()
    var clientIdObj = [Int]()
    
    var caseList = [String]()
    var caseIdObj = [Int]()
    
   
    
    var activityList = [String]()
    var activityIdObj = [Int]()
    
    var associateIdObj = [Int]()
    
    var clientIdIndex:Int!
    var caseIdIndex:Int!
    var activityIndex:Int!
    
    
    
    var dataTask:URLSessionDataTask?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print("my calendar:\(associateId)")
        print("my calendar:\(masterClientId)")
        print("my calendar:\(associateName)")
        
        
//       UserDefaults.standard.set(associateId, forKey: "key1")
//         UserDefaults.standard.set(masterClientId, forKey: "key2")
//         UserDefaults.standard.set(associateName, forKey: "key3")
//        
//        
//       
//        
//        UserDefaults.standard.synchronize()
        
        
        
        associateId =  UserDefaults.standard.integer(forKey: "key1")
        
        masterClientId =  UserDefaults.standard.integer(forKey: "key2")
        associateName =  UserDefaults.standard.string(forKey: "key3")
        

        
        
        
        
       // print(associateStored)
//          print(masterClientStored)
//          print(associateNameStored)

        self.navigationItem.title = "MY TIME CARDS"
        
        
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy"
//        let result = formatter.string(from: date)
//        dateField.text = result
        //        nextActivityDateField.text = result
        
        textView.delegate = self
        otherExpField.delegate = self
        //nextActivityDateField.delegate = self
        
        otherExpField.keyboardType = .numberPad
        textView.keyboardType = .default
        
        textView.autocorrectionType = .no
        
        addDoneButtonOnKeyboard()
        
        //        textField.font = UIFont.boldSystemFont(ofSize: 16)
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        
        otherExpField.layer.borderColor = UIColor.gray.cgColor
        otherExpField.layer.borderWidth = 1.0
        otherExpField.layer.cornerRadius = 5
        //        textView.layer.masksToBounds = false
        
        //        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = false
        
        caseTextfield.layer.borderColor = UIColor.gray.cgColor
        caseTextfield.layer.borderWidth = 1.0
        caseTextfield.layer.cornerRadius = 5
        caseTextfield.layer.masksToBounds = false
        
        activityField.layer.borderColor = UIColor.gray.cgColor
        activityField.layer.borderWidth = 1.0
        activityField.layer.cornerRadius = 5
        activityField.layer.masksToBounds = false
        
        dateField.layer.borderColor = UIColor.gray.cgColor
        dateField.layer.borderWidth = 1.0
        dateField.layer.cornerRadius = 5
        dateField.layer.masksToBounds = false
        
//        nextActivityDateField.layer.borderColor = UIColor.gray.cgColor
//        nextActivityDateField.layer.borderWidth = 1.0
//        nextActivityDateField.layer.cornerRadius = 5
//        nextActivityDateField.layer.masksToBounds = false
//        
        timeField.layer.borderColor = UIColor.gray.cgColor
        timeField.layer.borderWidth = 1.0
        timeField.layer.cornerRadius = 5
        timeField.layer.masksToBounds = false
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "menuIconImg"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(MyTimeCardsViewController.menuButtonPressed), for: UIControlEvents.touchUpInside)
        
        //set frame
        
        //        button.backgroundColor = UIColor.black
        
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        //        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        //        self.navigationItem.leftBarButtonItem = barButton
        
        let homeButton = UIButton(type: .custom)
        //set image for button
        homeButton.setImage(UIImage(named: "logoutImg"), for: UIControlState.normal)
        //add function for button
        homeButton.addTarget(self, action: #selector(MyTimeCardsViewController.homeButtonPressed), for: UIControlEvents.touchUpInside)
        
        //set frame
        
        //        homeButton.backgroundColor = UIColor.black
        
        homeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton1 = UIBarButtonItem(customView: homeButton)
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton1
        
        
        //        self.navigationItem.setRightBarButton(barButton1, animated: true)
        
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.caseTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellidentifier)
        self.activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: activityIdentifier)
        self.timeTableView.register(UITableViewCell.self, forCellReuseIdentifier: timeIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        tableView.layer.cornerRadius = 10
        caseTableView.layer.cornerRadius = 10
        activityTableView.layer.cornerRadius = 10
        timeTableView.layer.cornerRadius = 10
        
        caseTableView.delegate = self
        caseTableView.dataSource = self
        caseTextfield.delegate = self
        
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityField.delegate = self
        
        timeTableView.delegate = self
        timeTableView.dataSource = self
        timeField.delegate = self
        dateField.delegate = self
        
        
        tableView.isHidden = true
        caseTableView.isHidden = true
        activityTableView.isHidden = true
        timeTableView.isHidden = true
        
        
//        datePickerView.isHidden = true
//        datePicker.isHidden = true
//        dateDoneOutlet.isHidden = true
        
        //nextDatePicker.isHidden = true
        
        // Manage tableView visibility via TouchDown in textField
        textField.addTarget(self, action: #selector(textFieldActive), for: UIControlEvents.touchDown)
        
        caseTextfield.addTarget(self, action: #selector(casetextFieldActive), for: UIControlEvents.touchDown)
        
        activityField.addTarget(self, action: #selector(activityFieldActive), for: UIControlEvents.touchDown)
        
//        dateField.addTarget(self, action: #selector(dateFieldActive), for: UIControlEvents.touchDown)
//        
//        nextActivityDateField.addTarget(self, action: #selector(nextDateFieldActive), for: UIControlEvents.touchDown)
//        
        timeField.addTarget(self, action: #selector(timeFieldActive), for: UIControlEvents.touchDown)
        
         dateField.addTarget(self, action: #selector(createFromDatepicker), for: UIControlEvents.touchDown)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.fetchSelectClients()
        self.fetchSelectCases()
        self.fetchSelectActivity()
        self.createFromDatepicker()
        
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
//
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
        super.viewDidAppear(animated)
        
        
        UserDefaults.standard.set(associateId, forKey: "key1")
        UserDefaults.standard.set(masterClientId, forKey: "key2")
        UserDefaults.standard.set(associateName, forKey: "key3")
        
        UserDefaults.standard.synchronize()
        
        
        
        
        
    }
    
    func createFromDatepicker()   {
        //formate of date
        fromDate.datePickerMode = .date
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //barbuttomitem
        let donebuttom = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonepressedFromDate))
        toolbar.setItems([donebuttom], animated: false)
        dateField.inputAccessoryView = toolbar
        //assgin datepicker to text field
        dateField.inputView = fromDate
        fromDate.maximumDate = Date()
        
        //timepickeroutlet.isUserInteractionEnabled = false
    }
    
    func DonepressedFromDate()  {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        dateField.text = dateformatter.string(from: fromDate.date)
        self.view.endEditing(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    //    }
    
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
    
    func menuButtonPressed() {
        
        //        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //
        //        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    func homeButtonPressed() {
        
        //       print("home button")
        
        //        let viewcontrollers:[UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        //        self.navigationController!.popToViewController(viewcontrollers[viewcontrollers.count - 2], animated: true)
        
        _ = navigationController?.popViewController(animated: true)
        
        
        //        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        //        navigationController?.popToRootViewController(animated:true)
        
    }
    
    override func viewDidLayoutSubviews()
    {
        // Assumption is we're supporting a small maximum number of entries
        // so will set height constraint to content size
        // Alternatively can set to another size, such as using row heights and setting frame
        //        heightConstraint.constant = 150
        //
        //        heightCase.constant = 80
        //
        //        heightActivity.constant = 150
        //
        //        heightTime.constant = 170
        
    }
    
    
    // Manage keyboard and tableView visibility
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        //         self.view.endEditing(true)
        
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != tableView
        {
            textField.endEditing(true)
            tableView.isHidden = true
        }
        if touch.view != caseTableView
        {
            caseTextfield.endEditing(true)
            caseTableView.isHidden = true
        }
        
        if touch.view != activityTableView
        {
            activityField.endEditing(true)
            activityTableView.isHidden = true
        }
        
        if touch.view != timeTableView
        {
            timeField.endEditing(true)
            timeTableView.isHidden = true
        }
        
//        
        if touch.view != fromDate
        {
            dateField.endEditing(true)
            //            timeField.endEditing(true)
            fromDate.isHidden = true
        }
    }
    
    // Toggle the tableView visibility when click on textField
    func textFieldActive() {
        
        //        DispatchQueue.main.async(execute: { () -> Void in
        
        //             self.tableView.isHidden = !self.tableView.isHidden
        //        self.fetchAutocompletePlaces()
        activityTableView.isHidden = true
        caseTableView.isHidden = true
        timeTableView.isHidden = true
        //datePickerView.isHidden = true
        
        if tableView.isHidden {
            
            tableView.isHidden = false
            
        }
        else{
            
            tableView.isHidden = true
            
        }
        
        //            self.fetchAutocompletePlaces()
        //        })
        
        
        //        self.tableView.reloadData()
        
        
    }
    
    func casetextFieldActive() {
        
        activityTableView.isHidden = true
        tableView.isHidden = true
        timeTableView.isHidden = true
        //datePickerView.isHidden = true
        caseTableView.isHidden = !caseTableView.isHidden
        
        
        
    }
    
    func activityFieldActive() {
        
        caseTableView.isHidden = true
        tableView.isHidden = true
        timeTableView.isHidden = true
        //datePickerView.isHidden = true
        activityTableView.isHidden = !activityTableView.isHidden
        
    }
    
    
    func timeFieldActive(){
        
        caseTableView.isHidden = true
        tableView.isHidden = true
        activityTableView.isHidden = true
        //datePickerView.isHidden = true
        
        timeTableView.isHidden = !timeTableView.isHidden
        
        let disalert: Bool = UserDefaults.standard.bool(forKey: "disalert")
        self.timeField.resignFirstResponder()
        self.timeField.tintColor = UIColor.blue
        if disalert {
            self.timeField.tintColor = UIColor.clear
            self.timeField.resignFirstResponder()
        }
        
        //        timeField.endEditing(true)
        
        //        timeField.clearsOnBeginEditing = false
        
        //        timeField.selectedTextRange = nil
        
        //        datePickerView.isHidden = !datePickerView.isHidden
        //
        //        datePicker.isHidden = false
        //        dateDoneOutlet.isHidden = false
        //
        //        datePicker.datePickerMode = .time
        //
        //        datePicker.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
        
    }
    
//    func nexthandleDatePicker(sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        nextDatePicker.minimumDate = Date()
//        nextActivityDateField.text = dateFormatter.string(from: sender.date)
//    }
    
//    func handleDatePicker(sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        
//        dateField.text = dateFormatter.string(from: sender.date)
//    }
    
    
    func handleTimePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeField.text = dateFormatter.string(from: sender.date)
    }
    
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TODO: Your app can do something when textField finishes editing
        print("The textField ended editing. Do something based on app requirements.")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateField {
            
            self.createFromDatepicker()
            return true
        }
        if textField == self.textField
            
        {
            
            self.caseTextfield.text = ""
        }
        
        return false //do not show keyboard nor cursor
    }
    
    
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.tableView {
            count = clientNameList.count
        }
        
        if tableView == self.caseTableView {
            count =  caseList.count
        }
        
        if tableView == self.activityTableView {
            count =  activityList.count
        }
        
        if tableView == self.timeTableView {
            count =  timeList.count
        }
        return count!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        var cell:UITableViewCell?
        
        // Set text from the data model
        
        if tableView == self.tableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell?.textLabel?.text = clientNameList[indexPath.row]
            
            
            cell?.textLabel?.font = textField.font
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
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            //            let previewDetail = caseList[indexPath.row]
            cell?.textLabel?.text = caseList[indexPath.row]
            cell?.textLabel?.font = caseTextfield.font
            cell?.layer.cornerRadius = 10.0
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            
        }
        
        if tableView == self.activityTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            //            let previewDetail = caseList[indexPath.row]
            cell?.textLabel?.text = activityList[indexPath.row]
            cell?.textLabel?.font = activityField.font
            cell?.layer.cornerRadius = 10.0
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            
        }
        
        if tableView == self.timeTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            //            let previewDetail = caseList[indexPath.row]
            cell?.textLabel?.text = timeList[indexPath.row]
            cell?.textLabel?.font = timeField.font
            cell?.layer.cornerRadius = 10.0
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            cell?.backgroundColor = UIColor.darkGray
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
            
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        
        if tableView == self.tableView {
            
            textField.text = clientNameList[indexPath.row]
            
            self.clientIdIndex = clientIdObj[indexPath.row]
            
            self.caseList.removeAll()
             self.postMethodSubsidiary()
            tableView.isHidden = true
            textField.endEditing(true)
            
        }
        
        if tableView == self.caseTableView {
            
            caseTextfield.text = caseList[indexPath.row]
            
            self.caseIdIndex = caseIdObj[indexPath.row]
            
            //            print("caseIdIndex:\(self.caseIdIndex as Int)")
            
            tableView.isHidden = true
            caseTextfield.endEditing(true)
            
        }
        
        if tableView == self.activityTableView {
            
            activityField.text = activityList[indexPath.row]
            
            self.activityIndex = activityIdObj[indexPath.row]
            
            //            print("activityIndex:\(self.activityIndex as Int)")
            
            tableView.isHidden = true
            activityField.endEditing(true)
            
        }
        
        if tableView == self.timeTableView {
            
            timeField.text = timeList[indexPath.row]
            
            if indexPath.row == 7 {
                
                timeField.text = ""
                
                let alert = UIAlertController(title: "Enter your Minutes", message: "", preferredStyle: .alert)
                
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.text = ""
                    
                    textField.keyboardType = UIKeyboardType.numberPad
                }
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    //                    print("Text field: \(textField?.text)")
                    
                    //                    self.timeField.text = textField?.text
                }))
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    //                    print("Text field: \(textField?.text)")
                    
                    self.timeField.text = textField?.text
                }))
                
                
                
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
            }
            
            tableView.isHidden = true
            timeField.endEditing(true)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    @IBAction func sideMenuAction(_ sender: Any) {
        
        
        //        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //
        //        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    
    
    @IBAction func dateDoneAction(_ sender: Any) {
        
        //datePickerView.isHidden = true
        
        
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
                            
                            
                            self.clientNameList.append(element["clientName"] as! String)
                            
                            self.clientIdObj.append(element["clientId"] as! Int)
                            
                            //                                print("clientNameList:\(self.clientIdObj)")
                            
                            
                        }
                        
                        
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.tableView.reloadData()
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
                            
                            
                            self.caseList.append(element["caseType"] as! String)
                            
                            self.caseIdObj.append(element["caseId"] as! Int)
                            
                            //                            print("caseList:\(self.caseList)")
                            
                            
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.caseTableView.reloadData()
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
                            
                            
                            self.activityList.append(element["nameActivity"] as! String)
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
    
    @IBAction func submitAction(_ sender: Any) {
        
        
        caseTableView.isHidden = true
        tableView.isHidden = true
        activityTableView.isHidden = true
        //datePickerView.isHidden = true
        timeTableView.isHidden = true
        
        if textField.text!.isEmpty {
            
        self.Displaymyalertmessage(usermessage: "Please Select Client")
            return
            
        }
            
        else if caseTextfield.text!.isEmpty {
            
        self.Displaymyalertmessage(usermessage: "Please Select Case")
            return
            
        }
            
        else if activityField.text!.isEmpty {
            
             self.Displaymyalertmessage(usermessage: "Please Select Activity")
            return
            
        }
            
        else if dateField.text!.isEmpty {
            
            self.Displaymyalertmessage(usermessage: "Please Select Date ")
            return
            
        }
            
            
        else if timeField.text!.isEmpty {
            
            self.Displaymyalertmessage(usermessage: "Please Select Time")
            return
            
        }
        else {
            
          
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating()
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            
            let clientID:String = String(clientIdIndex)
            let caseID:String = String(caseIdIndex)
            let activityID:String = String(activityIndex)
            let associateID:String = String(associateId)
            //            let timeObj:String = String(hourObj)
            let timeObj:String = timeField.text!
            let dateObj:String = dateField.text!
            let noteObj:String = textView.text!
            let otherXpObj:String = otherExpField.text!
           // let nextActivity:String = nextActivityDateField.text!
            
            //        print("clientID:\(clientID)")
            //        print("caseID:\(caseID)")
            //        print("activityID:\(activityID)")
            //        print("dateObj:\(dateObj)")
            //        print("timeObj:\(timeObj)")
            
            
            let json = [ "client":clientID,"associate":associateID,"activities":activityID,"hour":timeObj,"caseID":caseID,"othexp":otherXpObj,"notes":noteObj,"date":dateObj] as [String : Any]
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            
            print("jsondata is:\(json)")
            
            var request = URLRequest(url: URL(string: "http://digilegal.neviton.com:8080/Legal-app/addTimeTracking")!)
            request.httpMethod = "POST"
            
            let postData:NSData?  =  jsonData as NSData?
            
            
            let postLength:NSString = NSString(format:"%d",postData!.length)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.httpBody = postData as Data?
            
            //        request.httpBody = body.data(using: .max)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        let alert = UIAlertView(title: "Error", message: "Could not connect to the server check your wifi or mobile data", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    
                self.dismiss(animated: false, completion: nil)
                    })
                    
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    
                    self.dismiss(animated: false, completion: nil)
                }
                
                
                let responseString = String(data: data, encoding: .utf8)
                
                
                print("responseString = \(String(describing: responseString))")
                
                let statusResp = "Record Added Successfully"
                
                if responseString == statusResp {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
                        
                        ViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        
                        self.addChildViewController(ViewController)
                        self.view.addSubview(ViewController.view)

                        
                        self.textField.text = ""
                        self.caseTextfield.text = ""
                        self.activityField.text = ""
                        self.timeField.text = ""
                        self.textView.text = ""
                        self.otherExpField.text = ""
                        self.dateField.text = ""
                        //self.nextActivityDateField.text = ""
                        self.dismiss(animated: false, completion: nil)
                        
                    })
                }
                else {
                    
                    DispatchQueue.main.async(execute: { () -> Void in
            
                        let alert = UIAlertView(title: "Error", message: "Failed to Add Record", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                         self.dismiss(animated: false, completion: nil)
                        
                      
                    })
                    
                    
                }
            }
            task.resume()
            
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        textField.text = ""
        caseTextfield.text = ""
        activityField.text = ""
        timeField.text = ""
        textView.text = ""
        otherExpField.text = ""
        dateField.text = ""
    }
    
   
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(MyTimeCardsViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.otherExpField.inputAccessoryView = doneToolbar
        self.textView.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        self.otherExpField.resignFirstResponder()
        self.textView.resignFirstResponder()
    }
    
    func Displaymyalertmessage(usermessage:String)
    {
        
        let  myalert = UIAlertController(title: "", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
        
    }

    
    
    
    
    
    func  postMethodSubsidiary() {
        
        let clientID:String = String(clientIdIndex)
        print("clientId is:\(clientID)")
        
        let masterClientIdObj:String = String(self.masterClientId)

        
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
                
                
                self.caseList.append(element.caseType!)
                
                //                    = [element.subClientName! as String]
                self.caseIdObj.append(element.caseId!)
                
                
            }
            
//            print("subsidiaryidObj is:\(self.subsidiaryIdObj)")
//            print("subsidiaryidObj is:\(self.subsidiaryNameArr)")
//            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.caseTableView.reloadData()
            })
            
            
            
        }
        task.resume()
        
    }
    

    
    
}




