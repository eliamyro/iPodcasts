//
//  APIService.swift
//  Podcasts
//
//  Created by Elias Myronidis on 01/02/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    typealias PodcastsSearchCompletion = ([Podcast]) -> Void
    typealias EpisodeFetchCompletion = ([Episode]) -> Void
    
    let baseiTuneSearchURL = "https://itunes.apple.com/search"
    
    // Singleton
    
    static let shared = APIService()
    
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping PodcastsSearchCompletion) {
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTuneSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Failed to contact yahoo.com", error.localizedDescription)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeError {
                print("Failed to decode json: ", decodeError.localizedDescription)
            }
        }
    }
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping EpisodeFetchCompletion) {
        guard let url = URL(string: feedUrl) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
            parser.parseAsync { (result) in
                if let error = result.error {
                    print("Faild to parse feed: ", error.localizedDescription)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
            }
        }
    }
}
