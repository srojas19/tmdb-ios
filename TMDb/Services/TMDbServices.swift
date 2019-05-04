//
//  TMDbServices.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation

class TMDbServices {
    
    static let shared = TMDbServices()
    
    private let apiKey: String
    private let session: URLSession
    
    private lazy var baseURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/")!
    }()

    
    private init() {
        if let path = Bundle.main.path(forResource: "TMDbService-info", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String:String],
            let apiKey = dictionary["API_KEY"] {
            self.apiKey = apiKey
        } else {
            apiKey = "NO KEY"
        }
        
        session = URLSession.shared
    }


    func fetch(mediaType: TMDbMediaType, category: TMDbCategory, page: Int,
                     completion: @escaping (Result<PagedMediaResponse, DataResponseError>) -> Void) {
        let urlRequest: URLRequest;
        switch category {
        case .popular:
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/popular"))
        case .topRated:
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/top_rated"))
        case .upcoming:
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/upcoming"))
        }
        
        let parameters = ["page": "\(page)", "api_key": "\(apiKey)"]
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data else {
                    completion(.failure(.network))
                    return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(PagedMediaResponse.self, from: data) else {
                completion(.failure(.decoding))
                return
            }
            
            completion(.success(decodedResponse))
        }).resume()
    }
    
}

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}
