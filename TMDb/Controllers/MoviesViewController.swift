//
//  MoviesViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 4/30/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func focusSearchBar(_ sender: Any) {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "Media Table":
            guard let mediaTableViewController = segue.destination as? MediaTableViewController
                else { fatalError("Unexpected View Controller") }
            mediaTableViewController.viewModel.mediaType = .movie
            addChild(mediaTableViewController)
            
        default:
            fatalError("Unidentified Segue")
        }
    }
    
}
