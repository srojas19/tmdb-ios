//
//  MediaListResult.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapperAdditions

@objcMembers
class MediaListResult: Object, Mappable {
    
    dynamic var posterPath: String? = nil
    dynamic var overview: String = ""
    dynamic var genreIds = List<Int>()
    dynamic var id = 0
    dynamic var backdropPath: String? = nil
    dynamic var popularity: Double = 0.0
    dynamic var voteCount = 0
    dynamic var voteAverage: Double = 0.0
    dynamic var originalLanguage: String? = nil
    
    dynamic var title: String? = nil
    dynamic var video = false
    dynamic var adult = false
    dynamic var releaseDate: String? = nil
    dynamic var originalTitle: String? = nil
    
    dynamic var firstAirDate: String? = nil
    dynamic var originCountry = List<String>()
    dynamic var name: String? = nil
    dynamic var originalName: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        posterPath <- map["poster_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        genreIds <- (map["genre_ids"], RealmTransform())
        id <- map["id"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        
        firstAirDate <- map["first_air_date"]
        originCountry <- (map["origin_country"], RealmTransform())
        name <- map["name"]
        originalName <- map["original_name"]

    }

}
