//
//  Movie.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct Movie: Media {
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
    
    let adult: Bool
    let belongsToCollection: TMDBCollection?
    let budget: Int?
    let imdbId: String?
    let originalTitle: String?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let tagline: String?
    let title: String
    let video: Bool
    
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
        
        case adult
        case belongsToCollection = "belongs_to_collection"
        case budget
        case imdbId = "imdb_id"
        case originalTitle = "original_title"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case tagline
        case title
        case video
    }
}
