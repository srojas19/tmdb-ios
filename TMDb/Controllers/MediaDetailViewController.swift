//
//  MediaDetailViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/4/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class MediaDetailViewController: UIViewController {
    
    let activityView = UIActivityIndicatorView(style: .white)
    let fadeView = UIView()
    
    var viewModel = MediaDetailViewModel()
    let bag = DisposeBag()
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var mediaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.media.filter{$0 != nil}.subscribe(onNext: { (media) in
            guard let view = self.view as? MediaDetailView,
                let media = media
                else { return }
            view.mediaImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(media.posterPath ?? "")"), placeholder: UIImage(named: "Media Placeholder"))
            view.backdropImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(media.backdropPath ?? "")"))
            
            self.descriptionLabel.text = media.overview
            if !media.genres.isEmpty {
                var genreString = ""
                media.genres.forEach { genreString += "\($0.name), "}
                genreString.removeLast()
                genreString.removeLast()
                view.genresLabel.text = genreString
            } else { view.genresLabel.text = nil }
            
            
            if !media.productionCompanies.isEmpty {
                view.productionCompaniesLabel.text = media.productionCompanies[0].name
            } else {
                view.productionCompaniesLabel.text = nil
            }
            
            view.averageScoreLabel.text = "\( media.voteAverage) ★"
            view.voteCountLabel.text = "\(media.voteCount) " + "Votes".localizedString
            view.popularityLabel.text = String(format:"%.1f",media.popularity.value ?? "No data".localizedString)
            if self.viewModel.mediaType == .movie, let media = media as? Movie {
                view.dateLabel.text = String(media.releaseDate?.split(separator: "-")[0] ?? "")
                if !media.spokenLanguages.isEmpty {
                    view.originalLanguageLabel.text = media.spokenLanguages[0].name
                }
                view.runtimeLabel.text = "\(media.runtime.value ?? 0) min"
                view.seasonsSection.isHidden = true
                view.episodesSection.isHidden = true
            } else if self.viewModel.mediaType == .tvShow, let media = media as? TVShow {
                view.dateLabel.text = media.status
                view.originalLanguageLabel.text = media.originalLanguage
                if !media.episodeRunTime.isEmpty {
                    view.runtimeLabel.text = "\(media.episodeRunTime[0]) min"
                } else {view.runtimeLabel.text = "?"}
                
                view.seasonsLabel.text = "\(media.numberOfSeasons.value ?? 0)"
                view.episodesLabel.text = "\(media.numberOfEpisodes.value ?? 0)"
            }
            
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.fadeView.alpha = 0
                self.activityView.stopAnimating()
                self.fadeView.removeFromSuperview()
            }, completion: nil)
            

        }).disposed(by: bag)
        
        viewModel.media.filter{$0 == nil}.subscribe(onNext: { (_) in
            self.fadeView.frame = self.view.frame
            self.fadeView.backgroundColor = UIColor(named: "Background")
            self.fadeView.alpha = 1
            
            self.view.addSubview(self.fadeView)
            self.view.addSubview(self.activityView)
            self.activityView.hidesWhenStopped = true
            self.activityView.center = self.view.center
            self.activityView.color = UIColor(named: "Main")
            self.activityView.startAnimating()

        }).disposed(by: bag)
        
        viewModel.getDetailedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = viewModel.mediaData.title ?? viewModel.mediaData.name
    }
    
    @IBAction func expandDescription(_ sender: UIButton) {
        if descriptionLabel.numberOfLines == 0 {
            sender.setTitle("more".localizedString, for: .normal)
            descriptionLabel.numberOfLines = 3
        } else {
            sender.setTitle("less".localizedString, for: .normal)
            descriptionLabel.numberOfLines = 0
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
