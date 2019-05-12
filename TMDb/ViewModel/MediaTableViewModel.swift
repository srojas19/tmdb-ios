//
//  MediaTableViewModel.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/11/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MediaTableViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class MediaTableViewModel {
    weak var delegate: MediaTableViewModelDelegate?
    
    var mediaType: TMDbMediaType!
    var category = TMDbCategory.popular
    
    var isFetchInProgress = false
    var media = [Int: [MediaListResult]]()
    var totalPages = 0
    var totalCount = 0
    let pageSize = 20
    
    var searchResults = [MediaListResult]()
    var isSearching = false

    
    func fetch(page: Int) {
        
        guard media[page] == nil else { return }
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        
        TMDbServices.shared.fetch(mediaType: mediaType, category: category, page: page) { result in
            switch result {
            case .failure(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.reason)
            case .success(let response):
                
                self.isFetchInProgress = false
                DispatchQueue.main.async {
                    self.media[page] = Array(response.results)
                    self.isFetchInProgress = false
                    if page == 1 {
                        self.totalCount = response.totalResults
                        self.totalPages = response.totalPages
                    }
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }

    
}
