//
//  DetailedMediaViewModel.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/11/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import Foundation
import RxSwift

struct MediaDetailViewModel {
    
    var mediaType: TMDbMediaType!
    var mediaData: MediaListResult!
    var media = BehaviorSubject<Media?>(value: nil)
    
    func getDetailedData() {
        TMDbServices.shared.getMediaDetail(mediaType: mediaType, id: mediaData.id) { result in
            switch result {
            case .failure(let error):
                print(error.reason)
            case .success(let response):
                DispatchQueue.main.async {
                    self.media.onNext(response)
                }
            }
        }
    }

    
}
