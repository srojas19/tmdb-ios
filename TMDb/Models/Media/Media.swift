//
//  Media.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift


protocol Media: Decodable {

    var backdropPath: String? { get }
    var genres: [Genre]?  { get }
    var homepage: String? { get }
    var id: Int { get }
    var originalLanguage: String? { get }
    var overview: String? { get }
    var popularity: Double? { get }
    var posterPath: String? { get }
    var productionCompanies: [ProductionCompany]?  { get }
    var status: String? { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }

}

/*
protocol Media: Object, EVReflectable {
    
    var backdropPath: String? { get }
    var genres: List<Genre>  { get }
    var homepage: String? { get }
    var id: Int { get }
    var originalLanguage: String? { get }
    var overview: String? { get }
    var popularity: Double { get }
    var posterPath: String? { get }
    var productionCompanies: List<ProductionCompany>  { get }
    var status: String? { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    
}
*/


