//
//  UIImage+Extensions.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

extension UIImage {
    
    public static func imageFrom(urlString: String, completion: @escaping (UIImage) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                return
            }
            completion(image)
            }.resume()
    }
}

