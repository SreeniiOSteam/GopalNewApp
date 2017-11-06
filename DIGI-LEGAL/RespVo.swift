//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class RespVo: Mappable {
    
    var id: Int?
    var response: String?
    var fName: String?
    var masterClientId: Int?
    var fee: Int?

    
    init(id:Int?,response:String?,fee:Int?,fName:String?,masterClientId:Int?) {
        self.id = id
        self.response = response
        self.fee = fee
        self.fName = fName
        self.masterClientId = masterClientId
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        response <- map["response"]
        fee <- map["fee"]
        fName <- map["fName"]
        masterClientId <- map["masterClienId"]
    }
}
