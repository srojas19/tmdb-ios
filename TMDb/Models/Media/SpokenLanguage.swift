//
//  SpokenLanguage.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

struct SpokenLanguage: Decodable {
    let iso: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name, iso = "iso_639_1"
    }
}
