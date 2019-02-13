//
//  Episode.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 13/02/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation
import FeedKit


struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
    }
}
