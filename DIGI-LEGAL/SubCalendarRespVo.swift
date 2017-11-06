//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class SubCalendarRespVo: Mappable {
    
    
    var response:String?
    
    var Name: String?
    var Next_act_date: String?
    var Next_act_date_to: String?
    var flag: String?
    var dateFrom: String?
    var timeFrom: String?
    var dateTo: String?
    var timeTo: String?


   
    
    init(Name:String?,Next_act_date:String?,Next_act_date_to:String?,flag:String?,dateFrom: String?,timeFrom: String?,dateTo: String?,timeTo: String?) {
        
        
        
        self.Name = Name
        self.Next_act_date = Next_act_date
        self.Next_act_date_to = Next_act_date_to
        self.flag = flag
        self.dateFrom = dateFrom

        self.timeFrom = timeFrom

        self.dateTo = dateTo
        self.timeTo = timeTo

        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        
        Name <- map["Name"]
        Next_act_date <- map["Next_act_date"]
       Next_act_date_to <- map["Next_act_date_to"]
        flag <- map["flag"]
        dateFrom <- map["dateFrom"]
        timeFrom <- map["timeFrom"]
        dateTo <- map["dateTo"]
        timeTo <- map["timeTo"]

      
    }
}
