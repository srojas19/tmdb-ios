//
//  Media.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


protocol Media {
    
    dynamic var genres: List<Genre> { get }
    dynamic var originalLanguage: String? { get }
    var popularity: RealmOptional<Double> { get }
    var productionCompanies: List<ProductionCompany> { get }
    dynamic var status: String? { get }
    dynamic var backdropPath: String? { get }
    dynamic var homepage: String? { get }
    dynamic var id: Int { get }
    dynamic var overview: String? { get }
    dynamic var posterPath: String? { get }
    dynamic var voteAverage: Double { get }
    dynamic var voteCount: Int { get }
}
