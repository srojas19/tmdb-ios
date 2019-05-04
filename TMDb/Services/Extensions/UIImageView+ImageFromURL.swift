//
//  UIImageView+ImageFromURL.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/2/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    public func imageFrom(urlString: String, placeholder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: NSString(string: urlString))
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

