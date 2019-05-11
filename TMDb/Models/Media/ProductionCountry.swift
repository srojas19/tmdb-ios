//
//  ProductionCountry.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers
class ProductionCountry: Object, Mappable  {
    dynamic var iso = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "iso"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        iso <- map["iso"]
        
    }
}

