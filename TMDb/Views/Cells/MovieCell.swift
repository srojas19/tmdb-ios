//
//  MovieCell.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/2/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    static let reusableIdentifier = "MovieCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, score: String, overview: String) {
        titleLabel.text = title
        scoreLabel.text = score
        overviewLabel.text = overview
    }
    
}
