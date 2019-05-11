//
//  Season.swift
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
class Season: Object, Mappable {
    dynamic var airDate: String? = nil
    var episodeCount = RealmOptional<Int>()
    dynamic var id = 0
    dynamic var name: String? = nil
    dynamic var overview: String? = nil
    dynamic var posterPath: String? = nil
    var seasonNumber = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        airDate <- map["air_date"]
        episodeCount <- (map["episode_count"], RealmOptionalTransform())
        id <- map["id"]
        name <- map["name"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        seasonNumber <- (map["season_number"], RealmOptionalTransform())
    }
}
