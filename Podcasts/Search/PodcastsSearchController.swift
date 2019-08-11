//
//  PodcastsSearchController.swift
//  Podcasts
//
//  Created by Elias Myronidis on 09/12/2018.
//  Copyright © 2018 eliamyro. All rights reserved.
//

import UIKit

class PodcastsSearchController: UITableViewController {
    
    let cellId = "cellId"
    
    var podcasts = [Podcast]()
    
    var timer: Timer?
    
    
    // MARK: - Views
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.delegate = self
        
        return sc
    }()
    
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
    }
    
    
    // MARK: - PodcastsSearchController Methods
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(PodcastCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
