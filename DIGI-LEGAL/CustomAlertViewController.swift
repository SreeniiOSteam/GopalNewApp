//
//  CustomAlertViewController.swift
//  DIGI-LEGAL
//
//  Created by Apple on 05/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
               
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func okActionTapped(_ sender: Any) {
        
       self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
}
