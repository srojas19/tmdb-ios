//
//  MediaTableViewController.swift
//  TMDb
//
//  Created by Santiago Rojas on 5/3/19.
//  Copyright © 2019 Santiago Rojas. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class MediaTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    
    var viewModel = MediaTableViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        let nib = UINib(nibName: "MediaCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MediaCell.reusableIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top += toolbar.bounds.height
        tableView.scrollIndicatorInsets.top += toolbar.bounds.height
        
        // SearchBar configuration
        parent?.definesPresentationContext = true
        parent?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        parent?.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        if let searchBar = parent?.navigationItem.searchController?.searchBar {
            searchBar.placeholder = parent is MoviesViewController ? "Filter movies".localizedString : "Filter TV shows".localizedString
            searchBar.tintColor = UIColor(named: "Main")
            searchBar.barStyle = .black
            searchBar.delegate = self
            searchBar.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)
        }
        
        viewModel.searchText
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter{ $0 != nil && $0!.count > 0 }
            .distinctUntilChanged()
            .subscribe(onNext: {
                self.categoriesSegmentedControl.isEnabled = false
                self.viewModel.isSearching = true
                self.viewModel.search(contains: $0!)
                self.tableView.reloadData()
                if !self.viewModel.searchResults.isEmpty {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }).disposed(by: disposeBag)
        
        viewModel.searchText
            .filter{ $0 == "" }
            .observeOn(MainScheduler.instance)
            .subscribe({_ in 
                self.viewModel.searchResults = []
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.fetch(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }
    
    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        viewModel.category = TMDbCategory(rawValue: sender.selectedSegmentIndex)!
        viewModel.media.removeAll()
        viewModel.fetch(page: 1)
        if viewModel.totalCount > 0 {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
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
            
            mediaDetailViewController.viewModel.mediaData = viewModel.isSearching ? viewModel.searchResults[indexPath.row] : viewModel.media[page]?[item]
            mediaDetailViewController.viewModel.mediaType = viewModel.mediaType
            
        default:
            fatalError("Unidentified Segue")
        }
        
    }
    
    
}

extension MediaTableViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearching { return viewModel.searchResults.count }
        else { return viewModel.totalCount }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.reusableIdentifier) as! MediaCell
        let page = (indexPath.row / 20) + 1
        let item = indexPath.row % 20
        if let media = viewModel.isSearching ? viewModel.searchResults[indexPath.row]: viewModel.media[page]?[item] {
            cell.configure(title: media.title ?? media.name ?? "" , score: media.voteAverage, overview: media.overview)
            cell.mediaImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(media.posterPath ?? "")"),placeholder: UIImage(named: "Media Placeholder"))
        } else { cell.loading() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !viewModel.isSearching, indexPaths.contains(where: { (indexPath) -> Bool in
            let page = (indexPath.row / 20) + 1
            let item = indexPath.row % 20
            return self.viewModel.media[page]?[item] == nil
        }) { viewModel.fetch(page: (indexPaths[0].row / 20) + 1) }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Show Detail", sender: indexPath)
    }
}

extension MediaTableViewController: MediaTableViewModelDelegate {
    func onFetchCompleted() { tableView.reloadData() }
    
    func onFetchFailed(with reason: String) {
        let title = "Warning".localizedString
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        let alertController = UIAlertController(title: title, message: reason, preferredStyle: .alert)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
}

extension MediaTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearching = false
        categoriesSegmentedControl.isEnabled = true
        viewModel.searchResults.removeAll(keepingCapacity: false)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
