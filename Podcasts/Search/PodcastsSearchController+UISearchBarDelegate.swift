//
//  PodcastsSearchController+UISearchControllerDelegate.swift
//  Podcasts
//
//  Created by Elias Myronidis on 09/12/2018.
//  Copyright © 2018 eliamyro. All rights reserved.
//

import UIKit
import Alamofire

extension PodcastsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                APIService.shared.fetchPodcasts(searchText: searchText) { podcasts in
                    self.podcasts = podcasts
                    self.tableView.reloadData()
                }
            })
        }
    }
}
