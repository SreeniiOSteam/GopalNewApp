//
//  DownloadCaseTableViewCell.swift
//  DIGI-LEGAL
//
//  Created by Apple on 05/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit

class DownloadCaseTableViewCell: UITableViewCell {
    
    @IBOutlet var downloadImageView: UIImageView!
    @IBOutlet var performTask: UIButton!
    @IBOutlet var fileNameLabel: UILabel!
    
    @IBOutlet var clientNameLabel: UILabel!
    
    @IBOutlet var caseNameLabel: UILabel!
    
    @IBOutlet var adminNameLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
