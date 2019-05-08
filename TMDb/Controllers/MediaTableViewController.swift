//
//  MediaTableViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/3/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit

class MediaTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    
    var mediaType: TMDbMediaType!
    var category = TMDbCategory.popular
    
    var isFetchInProgress = false;
    var media = [Int: [MediaListResult]]()
    var totalPages = 0
    var totalCount = 0
    let pageSize = 20
    
    var searchResults = [MediaListResult]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MediaCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MediaCell.reusableIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top += toolbar.bounds.height
        tableView.scrollIndicatorInsets.top += toolbar.bounds.height
        toolbar.delegate = self
        
        
        // SearchBar configuration
        parent?.definesPresentationContext = true
        parent?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        parent?.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        parent?.navigationItem.searchController?.delegate = self
        if let searchBar = parent?.navigationItem.searchController?.searchBar {
            searchBar.placeholder = parent is MoviesViewController ? "Filter movies".localizedString : "Filter TV shows".localizedString
            searchBar.delegate = self
        }
        
        fetch(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        category = TMDbCategory(rawValue: sender.selectedSegmentIndex)!
        media.removeAll()
        totalPages = 0
        totalCount = 0
        fetch(page: 1)
        if totalCount > 0 {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
        
    }
    
    private func fetch(page: Int) {
        
        guard media[page] == nil else { return }
        guard !isFetchInProgress else { return}
        
        isFetchInProgress = true
        
        TMDbServices.shared.fetch(mediaType: mediaType, category: category, page: page) { result in
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
                self.media[page] = response.results
                self.isFetchInProgress = false
                DispatchQueue.main.async {
                    if page == 1 {
                        self.totalCount = response.totalResults
                        self.totalPages = response.totalPages
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "Show Detail":
            guard let mediaDetailViewController = segue.destination as? MediaDetailViewController,
                let indexPath = sender as? IndexPath else { return }
            let page = (indexPath.row / 20) + 1
            let item = indexPath.row % 20
            
            mediaDetailViewController.mediaData = isSearching ? searchResults[indexPath.row] : media[page]?[item]
            mediaDetailViewController.mediaType = mediaType
            
        default:
            fatalError("Unidentified Segue")
        }
        
    }
    
    
}

extension MediaTableViewController: UIToolbarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

extension MediaTableViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return searchResults.count }
        else { return totalCount }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.reusableIdentifier) as! MediaCell
        let page = (indexPath.row / 20) + 1
        let item = indexPath.row % 20
        if isSearching {
            let media = searchResults[indexPath.row]
            cell.configure(title: media.title ?? media.name ?? "" , score: media.voteAverage, overview: media.overview)
            cell.mediaImage.imageFrom(urlString: "https://image.tmdb.org/t/p/w500\(media.posterPath ?? "")", placeholder: UIImage(named: "Media Placeholder"))
        } else if let media = media[page]?[item] {
            cell.configure(title: media.title ?? media.name ?? "" , score: media.voteAverage, overview: media.overview)
            cell.mediaImage.imageFrom(urlString: "https://image.tmdb.org/t/p/w500\(media.posterPath ?? "")", placeholder: UIImage(named: "Media Placeholder"))
        } else {
            cell.loading()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !isSearching, indexPaths.contains(where: { (indexPath) -> Bool in
            let page = (indexPath.row / 20) + 1
            let item = indexPath.row % 20
            return self.media[page]?[item] == nil
        }) { fetch(page: (indexPaths[0].row / 20) + 1) }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Detail", sender: indexPath)
    }
}

extension MediaTableViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        categoriesSegmentedControl.isEnabled = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        categoriesSegmentedControl.isEnabled = true
        searchResults.removeAll(keepingCapacity: false)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            searchResults.removeAll(keepingCapacity: true)
            for (_, page) in media {
                searchResults += page.filter { $0.name?.range(of: text, options: .caseInsensitive) != nil || $0.title?.range(of: text, options: .caseInsensitive) != nil}
            }
            tableView.reloadData()
        }
        
    }
}
