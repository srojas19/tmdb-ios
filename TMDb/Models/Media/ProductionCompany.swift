//
//  ProductionCompany.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct ProductionCompany: Decodable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case name, id, logoPath = "logo_path", originCountry = "origin_country"
    }

}
