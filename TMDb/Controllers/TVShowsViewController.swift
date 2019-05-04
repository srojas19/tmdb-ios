//
//  TVShowsViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 4/30/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let mediaViewController = MediaTableViewController()
        mediaViewController.mediaType = .tvShow

        let mediaView = mediaViewController.view!
        view.addSubview(mediaView)
        addChild(mediaViewController)
        mediaViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            mediaView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mediaView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mediaView.topAnchor.constraint(equalTo: view.topAnchor),
            mediaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
