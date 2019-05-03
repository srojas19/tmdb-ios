//
//  PagedMovieResponse.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct PagedMovieResponse: Decodable {
    let results: [Movie]
    let dates: [String: String]?
    let totalPages: Int
    let totalResults: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case dates = "dates"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page = "page"
    }
}
