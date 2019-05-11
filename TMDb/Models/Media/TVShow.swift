//
//  TVShow.swift
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
class TVShow: Object, Media, Mappable {
    dynamic var genres = List<Genre>()
    dynamic var originalLanguage: String? = nil
    var popularity = RealmOptional<Double>()
    var productionCompanies = List<ProductionCompany>()
    dynamic var status: String? = nil
    dynamic var backdropPath: String? = nil
    dynamic var homepage: String? = nil
    dynamic var id = 0
    dynamic var overview: String? = nil
    dynamic var posterPath: String? = nil
    dynamic var voteAverage: Double = 0.0
    dynamic var voteCount = 0
    
    var createdBy = List<Creator>()
    var episodeRunTime = List<Int>()
    dynamic var firstAirDate: String? = nil
    var inProduction = RealmOptional<Bool>()
    var languages = List<String>()
    dynamic var lastAirDate: String? = nil
    dynamic var lastEpisodeToAir: Episode?
    dynamic var name = ""
    var networks = List<ProductionCompany>()
    var numberOfEpisodes = RealmOptional<Int>()
    var numberOfSeasons = RealmOptional<Int>()
    var originCountry = List<String>()
    dynamic var originalName: String? = nil
    var seasons =  List<Season>()
    dynamic var type: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        genres <- (map["genres"], ListTransform<Genre>())
        originalLanguage <- map["original_language"]
        popularity <- (map["popularity"], RealmOptionalTransform())
        productionCompanies <- (map["production_companies"], ListTransform<ProductionCompany>())
        status <- map["status"]
        backdropPath <- map["backdrop_path"]
        homepage <- map["homepage"]
        id <- map["id"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        
        createdBy <- (map["created_by"], ListTransform<Creator>())
        episodeRunTime <- (map["episode_run_time"], RealmTransform())
        firstAirDate <- map["first_air_date"]
        inProduction <- (map["in_production"], RealmOptionalTransform())
        languages <- (map["languages"], RealmTransform())
        lastAirDate <- map["last_air_date"]
        lastEpisodeToAir <- map["last_episode_to_air"]
        name <- map["name"]
        networks <- (map["networks"], RealmTransform())
        numberOfEpisodes <- (map["number_of_episodes"], RealmOptionalTransform())
        numberOfSeasons <- (map["number_of_seasons"], RealmOptionalTransform())
        originCountry <- (map["origin_country"], RealmTransform())
        originalName <- map["original_name"]
        seasons <- (map["seasons"], RealmTransform())
        type <- map["type"]
    }
}
