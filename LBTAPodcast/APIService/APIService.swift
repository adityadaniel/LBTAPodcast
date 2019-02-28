//
//  APIService.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/01/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit


class APIService {
    
    // Singleton
    static let shared = APIService()
    
    struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
    
    func fetchPodcasts(with searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url,  method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (responseData) in
            if let err = responseData.error {
                print("Failed to fetch data", err)
                return
            }
            guard let data = responseData.data else { return }
            
            do {
                let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResults.results)
            } catch let decodeErr {
                print("Failed to decode", decodeErr)
            }
            
        }
    }
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.toSecureHTTPS()
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            
            if let err = result.error {
                print("Failed to parse XML results", err)
                return
            }
            
            guard let feed = result.rssFeed else { return }
            let episodes = feed.toEpisodes()
            completionHandler(episodes)
        }
    }
    
}
