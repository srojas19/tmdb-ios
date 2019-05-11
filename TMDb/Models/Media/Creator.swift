//
//  Creator.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

@objcMembers
class Creator: Object, Mappable {

    dynamic var id = 0
    dynamic var creditId: String? = nil
    dynamic var name: String? = nil
    var gender = RealmOptional<Int>()
    dynamic var profilePath: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        creditId <- map["credit_id"]
        name <- map["name"]
        gender <- (map["gender"], RealmOptionalTransform())
        profilePath <- map["profile_path"]
    }

}
