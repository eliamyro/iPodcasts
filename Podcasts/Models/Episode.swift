//
//  Episode.swift
//  Podcasts
//
//  Created by Elias Myronidis on 24/03/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let author: String
    let pubDate: Date
    let description: String
    var imageUrl: String?
    let streamUrl: String
    
    init(feedItem: RSSFeedItem) {
        streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        title = feedItem.title ?? ""
        author = feedItem.iTunes?.iTunesAuthor ?? ""
        pubDate = feedItem.pubDate ?? Date()
        description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}
