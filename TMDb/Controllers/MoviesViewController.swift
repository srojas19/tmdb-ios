//
//  MoviesViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 4/30/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    let mediaType = TMDbMediaType.movies
    var category = TMDbCategory.popular
    
    var isFetchInProgress = false;
    var movies = [Int: [Movie]]()
    var totalPages = 0
    var totalCount = 0
    let pageSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Popular Movies"
        
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieCell.reusableIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top += CGFloat(44)
        tableView.scrollIndicatorInsets.top += CGFloat(44)
        toolbar.delegate = self
        
        fetchMovies(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        category = TMDbCategory(rawValue: sender.selectedSegmentIndex)!
        switch category {
        case .popular:
            navigationItem.title = "Popular Movies"
        case .topRated:
            navigationItem.title = "Top Rated Movies"
        case .upcoming:
            navigationItem.title = "Upcoming Movies"
        }
        
        movies.removeAll()
        fetchMovies(page: 1)
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        
    }
    
    private func fetchMovies(page: Int) {
        
        guard movies[page] == nil else {
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        TMDbServices.shared.fetchMovies(ofCategory: category, page: page) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    
                    let title = "Warning".localizedString
                    let action = UIAlertAction(title: "OK".localizedString, style: .default)
                    
                    let alertController = UIAlertController(title: title, message: error.reason, preferredStyle: .alert)
                    alertController.addAction(action)
                    
                    self.present(alertController, animated: true)
                    
                }
            case .success(let response):
                self.movies[page] = response.results
                self.isFetchInProgress = false
                DispatchQueue.main.async {
                    if page == 1 {
                        self.totalCount = response.totalResults
                        self.totalPages = response.totalPages
                        self.tableView.reloadData()
                    } else {
                        self.tableView.reloadRows(at: self.visibleIndexPathsToReload(forPage: page) , with: .automatic)
                    }
                }
            }
        }
    }
    
    func visibleIndexPathsToReload(forPage page: Int) -> [IndexPath] {
        let startIndex = (page - 1) * 20
        let endIndex = startIndex + 20
        let indexPaths =  (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
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

extension MoviesViewController: UIToolbarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reusableIdentifier) as! MovieCell
        let page = (indexPath.row / 20) + 1
        let item = indexPath.row % 20
        if let movie = movies[page]?[item] {
            cell.configure(title: movie.title, score: "\(movie.voteAverage) %", overview: movie.overview)
            cell.movieImage.imageFromURL(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        } else {
            cell.configure(title: "Test", score: "1%", overview: "Lorem ipsum")
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { (indexPath) -> Bool in
            let page = (indexPath.row / 20) + 1
            let item = indexPath.row % 20
            return self.movies[page]?[item] == nil
        }) {
            fetchMovies(page: (indexPaths[0].row / 20) + 1)
        }
    }
}
