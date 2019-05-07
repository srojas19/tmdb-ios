//
//  TMDBCollection.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct TMDBCollection: Decodable {
    let backdropPath: String?
    let id: Int?
    let name: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case posterPath = "poster_path"
    }

}
