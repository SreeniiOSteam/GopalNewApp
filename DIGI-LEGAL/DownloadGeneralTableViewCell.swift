//
//  DownloadGeneralTableViewCell.swift
//  DIGI-LEGAL
//
//  Created by Apple on 05/10/17.
//  Copyright © 2017 Sunkpo. All rights reserved.
//

import UIKit

class DownloadGeneralTableViewCell: UITableViewCell {
    @IBOutlet var downloadImage: UIImageView!
   
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var adminNameLabel: UILabel!
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var performTask: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
