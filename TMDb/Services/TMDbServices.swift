//
//  TMDbServices.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/1/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RealmSwift

class TMDbServices {
    
    static let shared = TMDbServices()
    
    private let realm = try! Realm()
    
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
        switch (mediaType, category) {
        case (_, .popular):
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/popular"))
        case (_, .topRated):
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/top_rated"))
        case (.movie, .upcoming):
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/upcoming"))
        case (.tvShow, .upcoming):
            urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/airing_today"))
        }
        
        let parameters = ["page": "\(page)", "api_key": "\(apiKey)", "language": Locale.current.languageCode!]
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        guard Reachability()!.connection != .none else {
            let response = realm.objects(PagedMediaResponse.self).filter("page = \(page) AND mediaType = '\(mediaType.rawValue)' AND category = \(category.rawValue)")
            if let response = response.first {
                completion(.success(response))
            } else {
                completion(.failure(.network))
            }
            return
        }
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data else {
                    completion(.failure(.network))
                    return
            }
            
            guard let decodedResponse = PagedMediaResponse(JSONString: String(data: data, encoding: .utf8)!) else {
                completion(.failure(.decoding))
                return
            }
            
            decodedResponse.category = category.rawValue
            decodedResponse.mediaType = mediaType.rawValue
            decodedResponse.id = "\(decodedResponse.page)\(decodedResponse.mediaType)\(decodedResponse.category)"
            DispatchQueue.main.async {
                try! self.realm.write {
                    self.realm.add(decodedResponse, update: true)
                }
                
            }
            completion(.success(decodedResponse))
            
        }).resume()
    }
    
    
    func getMediaDetail(mediaType: TMDbMediaType, id: Int, completion: @escaping (Result<Media, DataResponseError>) -> Void) {
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/\(id)"))
        let parameters = ["append_to_response": "videos", "api_key": "\(apiKey)", "language": Locale.current.languageCode!]
        let encodedURLRequest = urlRequest.encode(with: parameters)
        guard Reachability()!.connection != .none else {
            switch mediaType {
            case .movie:
                if let response = realm.object(ofType: Movie.self, forPrimaryKey: id) {
                    completion(.success(response))
                } else { completion(.failure(.network)) }
            case .tvShow:
                if let response = realm.object(ofType: TVShow.self, forPrimaryKey: id) {
                    completion(.success(response))
                } else { completion(.failure(.network)) }
            }
            return
        }
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data else {
                    completion(.failure(.network))
                    return
            }
            
            switch mediaType {
            case .movie:
                guard let decodedResponse = Movie(JSONString: String(data: data, encoding: .utf8)!) else {
                    completion(.failure(.decoding))
                    return
                }
                DispatchQueue.main.async {
                    try! self.realm.write {
                        self.realm.add(decodedResponse, update: true)
                    }
                }
                completion(.success(decodedResponse))
            case .tvShow:
                guard let decodedResponse = TVShow(JSONString: String(data: data, encoding: .utf8)!) else {
                    completion(.failure(.decoding))
                    return
                }
                DispatchQueue.main.async {
                    try! self.realm.write {
                        self.realm.add(decodedResponse, update: true)
                    }
                }
                completion(.success(decodedResponse))
            }
        }).resume()
        
    }

    
    /*
    func getMediaDetail(mediaType: TMDbMediaType, id: Int, completion: @escaping (Result<Media, DataResponseError>) -> Void) {
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent("\(mediaType.rawValue)/\(id)"))
        let parameters = ["append_to_response": "videos", "api_key": "\(apiKey)", "language": Locale.current.languageCode!]
        let encodedURLRequest = urlRequest.encode(with: parameters)
        guard Reachability()!.connection != .none else {
            if let response = URLCache.shared.cachedResponse(for: encodedURLRequest) {
                if mediaType == .movie, let decodedResponse = try? JSONDecoder().decode(Movie.self, from: response.data) {
                    completion(.success(decodedResponse))
                } else if mediaType == .tvShow, let decodedResponse = try? JSONDecoder().decode(TVShow.self, from: response.data) {
                    completion(.success(decodedResponse))
                } else {
                    completion(.failure(.decoding))
                }
            } else {
                completion(.failure(.network))
            }
            return
        }
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode),
                let data = data else {
                    completion(.failure(.network))
                    return
            }
            
            /*
             do {
             let decodedResponse = try JSONDecoder().decode(TVShow.self, from: data)
             }
             catch {
             print("\(error)")
             }
             */
            
            if mediaType == .movie, let decodedResponse = try? JSONDecoder().decode(Movie.self, from: data) {
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: encodedURLRequest)
                completion(.success(decodedResponse))
            } else if mediaType == .tvShow, let decodedResponse = try? JSONDecoder().decode(TVShow.self, from: data) {
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: encodedURLRequest)
                completion(.success(decodedResponse))
            } else {
                completion(.failure(.decoding))
            }
            
        }).resume()
        
    }
    */
    
}
