//
//  RSSFeed.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/02/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import FeedKit

extension RSSFeed {
    
    func toEpisodes() -> [Episode] {
        let imageURL = iTunes?.iTunesImage?.attributes?.href?.toSecureHTTPS()
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var ep = Episode(feedItem: feedItem)
            if ep.imageURL == nil {
                ep.imageURL = imageURL
            }
            episodes.append(ep)
        })
        return episodes
    }
    
}
