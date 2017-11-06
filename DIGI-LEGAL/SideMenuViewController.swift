import UIKit

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var myTable: UITableView!
    var menulist:Array = [String]()
    
    var uploadlist:Array = [String]()
    
    var downloadlist:Array = [String]()
    
    var timeCards:Array = [String]()
    
    var associateNameStored:String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         self.profileNameLabel.text =  UserDefaults.standard.string(forKey: "key3")
        
        
        self.myTable.separatorColor = UIColor.clear
        
        menulist = ["MY TIME CARDS","ACTIVITY SCHEDULER","ASSOCIATE CALENDAR"]
        
        uploadlist = ["GENERAL","CASE RELATED"]
        
        downloadlist = ["GENERAL","CASE RELATED"]
        
        timeCards = ["LOGOUT"]
        
        
        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
       // self.profileNameLabel.text = associateNameStored

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.profileNameLabel.text =  UserDefaults.standard.string(forKey: "key3")
        
        super.viewWillAppear(animated)
        
       

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0
            
        {
            return menulist.count
        }
        if section == 1
            
        {
            return uploadlist.count
        }
        if section == 2
            
        {
            return downloadlist.count
        }
        else
        {
            return timeCards.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {
            return ""
        }
        if section == 1
        {
            return "UPLOAD"
        }
        if section == 2
        {
            return "DOWNLOAD"
        }
            
        else
        {
            return ""
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if section == 1
        {
            let customTitleView = UIView(frame: CGRect(x: 20, y: 0, width: 300, height: 44))
            let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 300, height: 32))
            titleLabel.text = "UPLOAD"
            titleLabel.textColor = UIColor.white
            titleLabel.backgroundColor = UIColor.clear
            customTitleView.addSubview(titleLabel)
            return customTitleView
        }
            
        else
            
        {
            let customTitleView = UIView(frame: CGRect(x: 20, y: 0, width: 300, height: 44))
            let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 300, height: 32))
            titleLabel.text = "DOWNLOAD"
            titleLabel.textColor = UIColor.white
            titleLabel.backgroundColor = UIColor.clear
            customTitleView.addSubview(titleLabel)
            return customTitleView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = myTable.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell
            
            
            
            cell?.dataLabel.text = menulist[indexPath.row]
            //cell?.sideMenuImgLabel.image = sideMenuBarIconsArr[indexPath.row]
            
            return cell!
        }
        if indexPath.section == 1
        {
            let cell = myTable.dequeueReusableCell(withIdentifier: "UploadTableViewCell", for: indexPath) as? UploadTableViewCell
            
            
            
            cell?.uploadLabel.text = uploadlist[indexPath.row]
            //cell?.sideMenuImgLabel.image = sideMenuBarIconsArr[indexPath.row]
            
            return cell!
        }
        
        if indexPath.section == 2
            
        {
            let cell = myTable.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as? DownloadTableViewCell
            cell?.downloadLabel.text = downloadlist[indexPath.row]
            //cell?.sideMenuImgLabel.image = otherSideMenuBarIconsArr[indexPath.row]
            return cell!
            
        }
        else
        {
            let cell = myTable.dequeueReusableCell(withIdentifier: "MyTimeCardsTableViewCell", for: indexPath) as? MyTimeCardsTableViewCell
            //            cell?..text = tim[indexPath.row]
            cell?.timeCardLabel.text = timeCards[indexPath.row]
            //cell?.sideMenuImgLabel.image = otherSideMenuBarIconsArr[indexPath.row]
            return cell!
            
}
}


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let cell:SideMenuTableViewCell = tableView.cellForRow(at: indexPath) as! SideMenuTableViewCell
            
            
            
            
            if cell.dataLabel.text == "MY TIME CARDS"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "MyTimeCardsViewController") as! MyTimeCardsViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
                
                
                self.profileNameLabel.text =  UserDefaults.standard.string(forKey: "key3")
                
                
                
            }
            
            
            
            if cell.dataLabel.text == "ACTIVITY SCHEDULER"
                
            {
                
                
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
            
            if cell.dataLabel.text == "ASSOCIATE CALENDAR"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
            
        }
        
        
        if indexPath.section == 1 {
            
            let cell:UploadTableViewCell = tableView.cellForRow(at: indexPath) as! UploadTableViewCell
            
            
            
            if cell.uploadLabel.text == "GENERAL"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "UploadGeneralViewController") as! UploadGeneralViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
            
            if cell.uploadLabel.text == "CASE RELATED"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "UploadCaseViewController") as! UploadCaseViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
        }
        
        if indexPath.section == 2
            
        {
            
            let cell:DownloadTableViewCell = tableView.cellForRow(at: indexPath) as! DownloadTableViewCell
            
            
            
            if cell.downloadLabel.text == "GENERAL"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "DownloadGeneralViewController") as! DownloadGeneralViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
            
            if cell.downloadLabel.text == "CASE RELATED"
                
            {
                let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "DownloadCaseViewController") as! DownloadCaseViewController
                let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
            }
            
        }
        
        if indexPath.section == 3
            
        {
            
            let cell:MyTimeCardsTableViewCell = tableView.cellForRow(at: indexPath) as! MyTimeCardsTableViewCell
            
            
    
            
            if cell.timeCardLabel.text == "LOGOUT"
                
            {
                let refreshAlert = UIAlertController(title: "Alert", message: "Are You Sure You Want To Logout?", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                    
                    let mainstoryoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                    let Desviewcontroller = mainstoryoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let newfrontviewcontroller = UINavigationController.init(rootViewController: Desviewcontroller)
                    self.revealViewController().pushFrontViewController(newfrontviewcontroller, animated: true)
                    
                    
                }))
                
                present(refreshAlert, animated: true, completion: nil)        }
            
    
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    
}
