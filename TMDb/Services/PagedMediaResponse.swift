//
//  PagedMovieResponse.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers
class PagedMediaResponse: Object, Mappable {
    
    dynamic var results =  List<MediaListResult>()
//    let dates: [String: String]?
    dynamic var totalPages = 0
    dynamic var totalResults = 0
    dynamic var page = 0
    dynamic var mediaType: String = ""
    dynamic var category = 0
    dynamic var id: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        results <- (map["results"], ListTransform<MediaListResult>())
//        dates <- map["dates"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        page <- map["page"]
    }
    
}
