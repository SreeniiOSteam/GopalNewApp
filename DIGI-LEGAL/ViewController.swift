//
//  ViewController.swift
//  DIGI-LEGAL
//
//  Created by srikanth on 10/3/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet var mobileNumberTxtFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 5.0
        
        mobileNumberTxtFiled.maxLength = 10
               
        mobileNumberTxtFiled.delegate = self as UITextFieldDelegate
        passwordTxtField.delegate = self as UITextFieldDelegate
        
        mobileNumberTxtFiled.keyboardType = .numberPad
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.clipsToBounds = true
        
        
        self.navigationItem.title = "DIGI-LEGAL"
       
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.addDoneButtonOnKeyboard()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mobileNumberTxtFiled.text = ""
        passwordTxtField.text = ""
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.removeNavigationBarItem()
//    }
    
    
    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.mobileNumberTxtFiled.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        self.mobileNumberTxtFiled.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //        self.view.endEditing(true)
        return true
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
            
        
            
            if (self.mobileNumberTxtFiled.text?.isEmpty)! {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.Displaymyalertmessage(usermessage:"Please  Enter Your Mobile Number")
                })
            }
            else if (self.passwordTxtField.text?.isEmpty)! {
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.Displaymyalertmessage(usermessage:"Please  Enter Your Password")
                    
                })
            }

            else {
                
                
                let mobileNumber:String = mobileNumberTxtFiled.text!
                let pword:String = passwordTxtField.text!
                
                let json = ["phoneNo":mobileNumber,"password":pword] as [String : Any]
                
                print("json: \(json)")
                
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                
                var request = URLRequest(url: URL(string:"http://digilegal.neviton.com:8080/Legal-app/validateUserCredentials")!)
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
                            
                            
                        })
                        
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                        
                    }
                    
                    let responseObj = String(data: data, encoding: .utf8)
                    
                    
                    let respVO:[RespVo] = Mapper<RespVo>().mapArray(JSONString: responseObj!)!
                    
                    print("responseString = \(respVO)")
                    
                    let resp = respVO[0].response
                    
                    let statusCode:String = "success"
                    let statusId:String = "fail"
                    
                if resp == statusId
                {

                    DispatchQueue.main.async(execute: { () -> Void in
                        let alert = UIAlertView(title: "Error", message: "Mobile or Password is incorrect", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                        
                    })
                    
                    
                    
                    }
                    
                    else if resp == statusCode
                {
                    
                    let idObj:Int  = respVO[0].id!
                    let fName:String = respVO[0].fName!
                    let masterClientIdObj:Int = respVO[0].masterClientId!
                    
                    UserDefaults.standard.set(idObj, forKey: "key1")
                    UserDefaults.standard.set(masterClientIdObj, forKey: "key2")
                    UserDefaults.standard.set(fName, forKey: "key3")
                    
                    UserDefaults.standard.synchronize()

                    
                    print("fName:\(fName)")
                    
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.navigationController?.view.makeToast("Logged in Successfully  ", duration: 1.5, position: .center)
                                
                                let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyTimeCardsViewController") as! MyTimeCardsViewController
                                
                            detailViewController.associateId = idObj
                            detailViewController.associateName = fName
                                detailViewController.masterClientId = masterClientIdObj
                                self.navigationController?.pushViewController(detailViewController, animated: true)
                            
                            
                            
                            UserDefaults.standard.set(detailViewController.associateId, forKey: "key1")
                            
                            
                            UserDefaults.standard.set(detailViewController.masterClientId, forKey: "key2")
                            
                            UserDefaults.standard.set(detailViewController.associateName, forKey: "key3")
                            
                            UserDefaults.standard.synchronize()
                            
                            
                            
                          
                            
                        })
            
                    }
                   
                    
                }
                task.resume()
                
                
            }
        }
        
    
    
    func Displaymyalertmessage(usermessage:String)
    {
        
        let  myalert = UIAlertController(title: "Alert", message: usermessage, preferredStyle: UIAlertControllerStyle.alert)
        let okaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okaction)
        
        self.present(myalert, animated: true, completion: nil)
        
    }
    
    
    }



