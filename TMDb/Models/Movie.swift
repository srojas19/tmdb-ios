//
//  Movie.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    
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
    }

}
