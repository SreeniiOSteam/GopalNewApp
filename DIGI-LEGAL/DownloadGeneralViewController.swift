//
//  DownloadGeneralViewController.swift
//  DIGI-LEGAL
//
//  Created by Apple on 04/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class DownloadGeneralViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating, UIDocumentInteractionControllerDelegate,URLSessionDownloadDelegate {
    
    
    @IBOutlet var dataDisplayTableView: UITableView!
    @IBOutlet var barButtonIcon: UIBarButtonItem!
    
    var downloadTask: URLSessionDownloadTask!
    var backgroundSession: URLSession!
    
//  var activityIndicatorView: UIActivityIndicatorView!
//  let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
//    
    var Str:String!
    
    
    //@IBOutlet var searchController: UISearchBar!
    var fileNameArr = [String]()
    var filterNameArr = [String]()
    
    var nameArr = [String]()
    var uploadArr = [String]()
    
    var fileNameObj = [String]()
    var uplDtObj = [String]()
    var actualFileName = [String]()
    var storedName:String = ""

    
    var uploaderNameObj = [String]()
    var filePathObj = [String]()
    var idObj = [Int]()
    
    var resultViewController = UITableViewController()
    var searchController = UISearchController()

     var dataTask:URLSessionDataTask?
    
    
    var associateStored:Int!
    var masterIdStored:Int!
    var associateNameStored:String!
    
    

    
    //var cell = DownloadGeneralTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        associateStored =  UserDefaults.standard.integer(forKey: "key1")
        
        masterIdStored =  UserDefaults.standard.integer(forKey: "key2")
        associateNameStored =  UserDefaults.standard.string(forKey: "key3")
        
        print("associateStored is :\(associateStored)")
        print("masterIdStored is :\(masterIdStored)")
        
        print("associateNameStored is :\(associateNameStored)")
        
     
        
        
       
       // progressView.setProgress(0.0, animated: false)
        
//        fileNameArr = ["GOPALFile","MANUFile","RAJUFile","GOPIFile","MANOJFile","MADHUFile","RAJIFile","RANIFile",]
//        nameArr = ["M","A","C","B","W","S","D","X"]
//        uploadArr = ["10-11-15","10-11-15","10-11-15","10-11-15","10-11-15","10-11-15","10-11-15","10-11-15"]
        
        
        self.navigationItem.title = "GENERAL DOCUMENTS"
        
        barButtonIcon.target = revealViewController()
        barButtonIcon.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        searchController = UISearchController(searchResultsController: resultViewController)
        dataDisplayTableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        resultViewController.tableView.delegate = self
        resultViewController.tableView.dataSource = self
        
        self.fetchGeneralDoc()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterNameArr = fileNameObj.filter({ (fileNameArr:String) -> Bool in
            if fileNameArr.contains(searchController.searchBar.text!)
            {
                return true
            }
            else{
                return false
            }
        })
        resultViewController.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        if tableView == resultViewController.tableView {
            
            return filterNameArr.count
        }
        else{
            return fileNameObj.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    

        let cell = dataDisplayTableView.dequeueReusableCell(withIdentifier: "DownloadGeneralTableViewCell", for: indexPath) as! DownloadGeneralTableViewCell
        
        if tableView == resultViewController.tableView {
            
            cell.fileNameLabel?.text = fileNameObj[indexPath.row]
            cell.adminNameLabel.text = uploaderNameObj[indexPath.row]
            cell.dateLabel.text = uplDtObj[indexPath.row]
        }
        else {
            cell.fileNameLabel?.text = fileNameObj[indexPath.row]
            cell.adminNameLabel.text = uploaderNameObj[indexPath.row]
            cell.dateLabel.text = uplDtObj[indexPath.row]
        }
        
        
       // cell.performTask.addTarget(self, action: #selector(buttonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            storedName = actualFileName[indexPath.row]
        
                print("name is thatt :\(storedName)")


        
        downloadVideoLinkAndCreateAsset("http://digilegal.neviton.com:8080/Legal-app/rest/download/101/\(storedName)")

        
       // downloadVideoLinkAndCreateAsset("http://digilegal.neviton.com:8080/Legal-app/rest/download/101/20171102T095155_images-1.jpg")
        
        
//        
//
//        
//        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
//        backgroundSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
//    
//        
//    storedName = actualFileName[indexPath.row]
//        
//    
//        
//        print("name is thatt :\(storedName)")
//        
//        let url = URL(string: "http://digilegal.neviton.com:8080/Legal-app/rest/download/101/\(storedName)")
//        
//        if url == nil
//        {
//            print("url is empty")
//        }
//        
//        else{
//        
//        
     //   self.downloadTask = self.backgroundSession.downloadTask(with: (url)!)
     //   self.downloadTask.resume()
//            
//        }
//        
//   
    }
    
    
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            
            // set up your download task
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                
                // use guard to unwrap your optional url
                guard let location = location else { return }
                
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                
                do {
                    
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    
                    PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                        
                        // check if user authorized access photos for your app
                        if authorizationStatus == .authorized {
                            PHPhotoLibrary.shared().performChanges({
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                    if completed {
                                        print("Video asset created")
                                    } else {
                                        print("error")
                                    }
                            }
                        }
                    })
                    
                } catch { print(error) }
                
                }.resume()
            
        } else {
            print("File already exists at destination url")
        }
        
    }


    

    
    
    // 1
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

    
    
    
    func fetchGeneralDoc() {
        
        let urlString = "http://digilegal.neviton.com:8080/Legal-app/retrieveGenDoc/101"
        
        
    let url  = NSURL(string: urlString)
                
    URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(Data,URLResponse,Error) -> Void in
                    
                    
                    
    if let jsonObj = try? JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as? NSDictionary
    {
        
    if let actorArray = jsonObj!.value(forKey: "response") as? NSArray
    {
        for actor in actorArray
        {
          
 if let actorDict = actor as? NSDictionary
    {
 if let fileNameobject = actorDict.value(forKey: "fileName")
    {
    self.fileNameObj.append(fileNameobject as! String)
    }
 if let name = actorDict.value(forKey: "uploaderName")
    
{
    self.uploaderNameObj.append(name as! String)
}
    if let name = actorDict.value(forKey: "uplDt")
        
    {
    self.uplDtObj.append(name as! String)
    }
                                    
 if let actualfileName = actorDict.value(forKey: "actualFileName")
    
    {
    self.actualFileName.append(actualfileName as! String)
    }
                                    
OperationQueue.main.addOperation ({
                                        
    self.dataDisplayTableView.reloadData()
                                        
                                    })
                                }
                            }
                }
                        
            }
    }).resume()
                
                
                
        }
    
    
    
    
}



