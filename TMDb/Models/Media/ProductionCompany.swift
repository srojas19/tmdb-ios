//
//  ProductionCompany.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers
class ProductionCompany: Object, Mappable {
    dynamic var name = ""
    dynamic var id = 0
    dynamic var logoPath: String? = nil
    dynamic var originCountry: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        logoPath <- map["logo_path"]
        originCountry <- map["origin_country"]
        
    }

}
