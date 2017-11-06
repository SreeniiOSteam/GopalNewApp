//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class SubRespVo: Mappable {
    
    var subClientId: Int?
    var subClientName: String?
    var fee: Int?
    
    
    var dtUpl: String?
    var fileName: String?
    var uploaderName: String?
    var caseName: String?
    var clientName: String?
    
    init(subClientId:Int?,subClientName:String?,fee:Int?,dtUpl:String?,fileName:String?,uploaderName:String?,caseName:String?,clientName:String?) {
        
      
        self.subClientId = subClientId
        self.subClientName = subClientName
        self.fee = fee
        self.dtUpl = dtUpl
        self.fileName = fileName
        self.uploaderName = uploaderName
        self.caseName = caseName
        self.clientName = clientName

    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
       
        subClientId <- map["subClientId"]
        subClientName <- map["subClientName"]
        fee <- map["fee"]
        dtUpl <- map["dtUpl"]
        fileName <- map["fileName"]
        uploaderName <- map["uploaderName"]
        caseName <- map["caseName"]
        clientName <- map["clientName"]
    }
}
