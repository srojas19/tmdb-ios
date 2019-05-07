//
//  TVShow.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct TVShow: Media {
    var genres: [Genre]?
    var originalLanguage: String?
    var popularity: Double?
    var productionCompanies: [ProductionCompany]?
    var status: String?
    var backdropPath: String?
    var homepage: String?
    var id: Int
    var overview: String?
    var posterPath: String?
    var voteAverage: Double
    var voteCount: Int
    
    
    var createdBy: [Creator]?
    var episodeRunTime: [Int]
    var firstAirDate: String?
    var inProduction: Bool?
    var languages: [String]
    var lastAirDate: String?
    var lastEpisodeToAir: Episode?
    var name: String
//    var nextEpisodeToAir: Episode?
    var networks: [ProductionCompany]?
    var numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    var originCountry: [String]
    var originalName: String?
    var seasons: [Season]?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case homepage
        case id
        case originalLanguage = "original_language"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case status
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
//        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalName = "original_name"
        case seasons
        case type
    }
}
