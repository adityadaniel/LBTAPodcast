//
//  Podcast.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/01/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    let trackName: String?
    let artistName: String?
    let trackCount: Int?
    let artworkUrl600: String?
    let feedUrl: String?
}
