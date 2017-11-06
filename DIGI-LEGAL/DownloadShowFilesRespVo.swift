//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class DownloadShowFilesRespVo: Mappable {
    
    var response: [SubDownloadRespVo]?
    var error:String?
    
    init(response: [SubDownloadRespVo]?,error:String?) {
        
        self.response = response
        self.error = error
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        error <- map["error"]
    }
}
