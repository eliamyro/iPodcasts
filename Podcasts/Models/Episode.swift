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
    let pubDate: Date
    let description: String
    
    init(feedItem: RSSFeedItem) {
        title = feedItem.title ?? ""
        pubDate = feedItem.pubDate ?? Date()
        description = feedItem.description ?? ""
    }
}
