//
//  TMDBCollection.swift
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
class TMDBCollection: Object, Mappable {
    dynamic var backdropPath: String? = nil
    dynamic var id: Int = 0
    dynamic var name: String? = nil
    dynamic var posterPath: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        backdropPath <- map["backdrop_path"]
        id <- map["id"]
        name <- map["name"]
        posterPath <- map["poster_path"]
    }

}
