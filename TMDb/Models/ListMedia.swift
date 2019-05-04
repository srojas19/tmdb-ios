//
//  Movie.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct ListMedia: Decodable {
    
    let posterPath: String? //
    let overview: String //
    let genreIds: [Int] //
    let id: Int //
    let backdropPath: String? //
    let popularity: Double //
    let voteCount: Int //
    let voteAverage: Double //
    let originalLanguage: String? //
    
    let title: String?
    let video: Bool?
    let adult: Bool?
    let releaseDate: String?
    let originalTitle: String?

    
    let firstAirDate: String? //
    let originCountry: [String]? //
    let name: String? //
    let originalName: String? //

    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
        
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case name = "name"
        case originalName = "original_name"
    }

}
