//
//  Episode.swift
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
class Episode: Object, Mappable {
    
    dynamic var airDate: String? = nil
    var episodeNumber = RealmOptional<Int>()
    dynamic var id = 0
    dynamic var name: String? = nil
    dynamic var overview: String? = nil
    dynamic var productionCode: String? = nil
    var seasonNumber = RealmOptional<Int>()
    var showId = RealmOptional<Int>()
    dynamic var stillPath: String? = nil
    var voteAverage = RealmOptional<Double>()
    var voteCount = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        airDate <- map["air_date"]
        episodeNumber <- (map["episode_number"], RealmOptionalTransform())
        id <- map["id"]
        name <- map["name"]
        overview <- map["overview"]
        productionCode <- map["production_code"]
        seasonNumber <- (map["season_number"], RealmOptionalTransform())
        showId <- (map["show_id"], RealmOptionalTransform())
        stillPath <- map["still_path"]
        voteAverage <- (map["vote_average"], RealmOptionalTransform())
        voteCount <- (map["vote_count"], RealmOptionalTransform())
        
    }

}
