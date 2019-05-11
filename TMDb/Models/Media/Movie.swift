//
//  Movie.swift
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
class Movie: Object, Media, Mappable {
    
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

    dynamic var adult = false
    var belongsToCollection: TMDBCollection?
    var budget = RealmOptional<Int>()
    dynamic var imdbId: String? = nil
    dynamic var originalTitle: String? = nil
    var productionCountries = List<ProductionCountry>()
    dynamic var releaseDate: String? = nil
    var revenue = RealmOptional<Int>()
    var runtime = RealmOptional<Int>()
    var spokenLanguages =  List<SpokenLanguage>()
    dynamic var tagline: String? = nil
    dynamic var title = ""
    dynamic var video = false
    
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
        
        adult <- map["adult"]
        belongsToCollection <- map["belongs_to_collection"]
        budget <- (map["budget"], RealmOptionalTransform())
        imdbId <- map["imdb_id"]
        originalTitle <- map["original_title"]
        productionCountries <- (map["production_countries"], ListTransform<ProductionCountry>())
        releaseDate <- map["release_date"]
        revenue <- (map["revenue"], RealmOptionalTransform())
        runtime <- (map["runtime"], RealmOptionalTransform())
        spokenLanguages <- (map["spoken_languages"], ListTransform<SpokenLanguage>())
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]

        
    }
}
