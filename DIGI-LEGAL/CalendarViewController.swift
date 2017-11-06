//
//  CalendarViewController.swift
//  DIGI-LEGAL
//
//  Created by srikanth on 10/3/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit
import JBDatePicker
import Foundation
//hhhhhhhhhhhhhhh
class CalendarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,JBDatePickerViewDelegate {
    
    @IBOutlet var calendarTableView: UITableView!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var calendarLabel: UILabel!
    @IBOutlet var associateNameTxtFiled: UITextField!
    
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    @IBOutlet weak var datePicker: JBDatePickerView!
    
    @IBOutlet var nextBtn: UIButton!
    
    var associateNameArr = [String]()
    var calendarFromDateArr = [String]()
    
    var calendarToDateArr = [String]()
    var calendarToDateArrDemo = [String]()

    
    var associateNameArr2 = [String]()
    var calendarFromDateArr2 = [String]()
    var calendarFromDateArr3 = [String]()


    var calendarToDateArr2 = [String]()
    
    var flagArr = [String]()
    
   // var stringDates = [Date]()
    var stringDates : [Date] = []

    var dateObjects = [Date]()

    let dayView:JBDatePickerDayView? = nil

    var associateNameIdObj = [String]()
    var calendarFromDateIdObj = [String]()
    
    var calendarToDateIdObj = [String]()
    
    var associatId:Int!
    
    let nextMonth:NSDate? = nil
    
    let dateFormatter = DateFormatter()

    var associateName:String!
    
    
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
        
               

      

        //self.manuObj()

        
        
        //self.didSelectDay(Date)
        
//        self.calendarTableView.isHidden = true
        
        self.navigationItem.title = "ASSOCIATE CALENDAR"
        
//        print("associatId is:\(MyVariables.associateId)")
//        print("associateName is:\(MyVariables.associateName)")
    
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        //self.navigationItem.title = "DIGI-LEGAL"
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.associateNameTxtFiled.text = associateNameStored
        
         self.associateNameTxtFiled.isUserInteractionEnabled = false
        
        self.calendarLabel.text = datePicker.presentedMonthView?.monthDescription
        
        datePicker.delegate = self
        
        let assciateName:String = String(associateStored)
        
        let json = ["associate":assciateName] as [String : Any]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        
        var request = URLRequest(url: URL(string: "http://digilegal.neviton.com:8080/Legal-app/calendarRest")!)
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
            
            let respVO:[CalendarRespVo] = Mapper<CalendarRespVo>().mapArray(JSONString: responseString!)!
            
            print("responseString = \(respVO)")
            
            
            let respStr = respVO[0].response
        
            
            
//            UserDefaults.standard.set(respStr, forKey: "dateResp")
//            
//            UserDefaults.standard.synchronize()
            
            print("respStr is:\(respStr)")
            
            for actor in respStr!
            
            {
                if let name = actor.flag {
                   // self.flagArr.append(name)
                    
                    if name == "C"
                    
                    {
                        if let name = actor.Name {
                            self.associateNameArr.append(name)
                            
                            print("name is that\(name)")
                           
                        }
                        if let name = actor.timeFrom {
                            self.calendarFromDateArr.append(name)
                        }
                        if let name = actor.Next_act_date_to {
                            self.calendarToDateArr.append(name)
                        }
                        
                        if let name = actor.dateFrom {
                            self.calendarToDateArrDemo.append(name)
                        }
                        
                    }
                    
                    else if name == "F"
                    
                    {
                        if let name = actor.Name {
                            self.associateNameArr2.append(name)
                        }
                        if let name = actor.dateFrom{
                            
                            self.calendarFromDateArr2.append(name)
                            
                            print("calendarFromDateArr2 is:\(self.calendarFromDateArr2)")
                            
                        }
                        if let name = actor.Next_act_date{
                            
                            self.calendarFromDateArr3.append(name)
                            
        
                            print("calendarFromDateArr3 is:\(self.calendarFromDateArr3)")
                            
                        }
                        
                        if let name = actor.timeFrom {
                            self.calendarToDateArr2.append(name)
                        }
                        
                    }
                    }
                
                
                }
            
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                
               // self.manuObj()

                
                self.calendarTableView.reloadData()
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                self.dateObjects = self.calendarFromDateArr3.flatMap { dateFormatter.date(from: $0) }
                
                
                
                
                print(self.dateObjects)
                
                print(self.calendarFromDateArr2)
                
            // dateObjects.append(JBDatePickerView)
                
            })
            }
        
        task.resume()
        
        
    }
//    func manuObj() {
//        
//        
//        for calendardate in self.calendarFromDateArr3
//            
//        {
//            print("calendardate:\(calendardate)")
//            
//            let dateFormatter = DateFormatter()
//            
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//            
//            var dateOb = dateFormatter.date(from: calendardate)
//            
//            print(dateOb)
//            
//            
//           let raj  = datePicker.delegate?.colorForCurrentDay
//           var jsj = datePicker.delegate?.selectionShape
//            
//            
//            let gopal = dateOb?.addTimeInterval(1.0)
//            
//            print("color is:\(jsj)")
//            
//            self.dayView?.selectAll(self.calendarFromDateArr3)
//            
//            
//            
//            print("self.dayView?.date : \(self.dayView?.date)")
//            return
//        }
//
//        
//    }
    
    

    
    // MARK: - JBDatePickerViewDelegate
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
       
        
        
        print("date selected: \(String(describing: dayView.date))")
       
    
        
        
       
        
        
        var clikedDate = dayView.date
        
        
        print("clikedDate is:\(clikedDate)")
        
        
        
        
//        for datedata in dateObjects
//
//        {
//            dayView.date = datedata
//        return
//        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        self.calendarTableView.isHidden = false

        
        if section == 0 {
            
            print("associateNameArr is that\(self.associateNameArr)")

            return associateNameArr.count
            
            
            
        }
        else
        {
            

            return associateNameArr2.count
            

 
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
        
        if indexPath.section == 0 {
            cell.dateLabel.text = calendarFromDateArr[indexPath.row]
            cell.activityLabel.text = associateNameArr[indexPath.row]
//            self.calendarTableView.reloadData()

            cell.timeLabel.text = ""
            return cell

        }
        else
        {
            cell.dateLabel.text = calendarFromDateArr2[indexPath.row]
            cell.activityLabel.text = associateNameArr2[indexPath.row]
            cell.timeLabel.text = calendarToDateArr2[indexPath.row]
//            self.calendarTableView.reloadData()

            
            return cell

        }
        
            }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            
            return "Today"
            
        }
        else
        {
            return "Upcoming"
        }
    }
    
    func didPresentOtherMonth(_ monthView: JBDatePickerMonthView) {
        
        
        self.calendarLabel.text = datePicker.presentedMonthView?.monthDescription
        
    
    }
    
    
    
    var weekDaysViewHeightRatio: CGFloat {
        return 0.1
    }
    
    
    @IBAction func previousBtn(_ sender: Any) {
        
        datePicker.loadPreviousView()
        
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        datePicker.loadNextView()
        
        
    }
}
