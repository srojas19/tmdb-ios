//
//  UIImageView+ImageFromURL.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/2/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imageFromURL(urlString: String) {
//        self.image = nil
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }.resume()
    }
}

