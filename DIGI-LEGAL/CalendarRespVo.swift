//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class CalendarRespVo: Mappable {
    
    var response: [SubCalendarRespVo]?
    
    init(response: [SubCalendarRespVo]?) {
        
        self.response = response
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        
        
    }
}
