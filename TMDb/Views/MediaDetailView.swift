//
//  MediaDetailView.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/5/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MediaDetailView: UIView {

    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var productionCompaniesLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    
    
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var seasonsSection: UIView!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var episodesSection: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        mediaImage.layer.masksToBounds = true;
        mediaImage.layer.cornerRadius = 5;
        backdropImage.layer.masksToBounds = true;
        backdropImage.layer.cornerRadius = 5;
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
