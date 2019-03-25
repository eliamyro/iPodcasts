//
//  Podcast.swift
//  Podcasts
//
//  Created by Elias Myronidis on 09/12/2018.
//  Copyright © 2018 eliamyro. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    
    var trackName: String?
    var artistName: String?
    var feedUrl: String?
    var trackCount: Int?
    var artworkUrl600: String?
}
