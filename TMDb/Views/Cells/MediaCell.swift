//
//  MovieCell.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/2/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    static let reusableIdentifier = "MediaCell"
    
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        mediaImage.layer.masksToBounds = true;
        mediaImage.layer.cornerRadius = 10;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, score: Double, overview: String) {
        titleLabel.text = title
        scoreLabel.text = score > 0 ? String(score) : "No score available"
        overviewLabel.text = !overview.isEmpty ? overview : "No description available"
    }
    
}
