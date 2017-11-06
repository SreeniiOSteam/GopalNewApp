//
//  RespVo.swift
//  BillLegalApp
//
//  Created by Apple on 28/03/17.
//  Copyright © 2017 AppleSunKPO. All rights reserved.
//

import Foundation

class SubDownloadRespVo: Mappable {
    
    
    var response:String?
    
    var caseId:Int?
    var caseType:String?
    
    
    var dtUpl: String?
    var fileName: String?
    var uploaderName: String?
    var caseName: String?
    var clientName: String?
    
    init(dtUpl:String?,fileName:String?,uploaderName:String?,caseName:String?,clientName:String?,caseId:Int?,caseType:String?) {
        
        
        self.caseId = caseId
        self.caseType = caseType

        self.dtUpl = dtUpl
        self.fileName = fileName
        self.uploaderName = uploaderName
        self.caseName = caseName
        self.clientName = clientName
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
       caseId <- map["caseId"]
        caseType <- map["caseType"]
        
        dtUpl <- map["dtUpl"]
        fileName <- map["fileName"]
        uploaderName <- map["uploaderName"]
        caseName <- map["caseName"]
        clientName <- map["clientName"]
    }
}
