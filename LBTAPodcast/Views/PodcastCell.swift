//
//  PodcastCell.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/01/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastTrackNameLabel: UILabel!
    @IBOutlet weak var podcastArtistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            podcastTrackNameLabel.text = podcast.trackName
            podcastArtistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) episodes"
            
            
            guard let url = URL(string: podcast.artworkUrl600 ?? "" ) else { return }
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
