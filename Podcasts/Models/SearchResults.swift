//
//  SearchResults.swift
//  Podcasts
//
//  Created by Elias Myronidis on 09/12/2018.
//  Copyright © 2018 eliamyro. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    
    let resultCount: Int
    let results: [Podcast]
}
