//
//  EpisodeCell.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 13/02/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode! {
        didSet {
            episodeImageView.image = UIImage(named: "appicon")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM, dd yyyy"
            
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
        }
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
}
