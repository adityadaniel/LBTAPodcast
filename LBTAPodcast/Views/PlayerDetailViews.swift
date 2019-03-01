//
//  PlayerDetailViews.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 01/03/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import AVKit

class PlayerDetailViews: UIView {
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            guard let url = URL(string: episode.imageURL ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
            authorLabel.text = episode.author
            
            playEpisode()
        }
    }
    
    fileprivate func playEpisode() {
        print("Trying to play episode: ", episode.streamURL)
        
        guard let url = URL(string: episode.streamURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBOutlet weak var episodeImageView: UIImageView! 
    
    @IBOutlet weak var episodeTitleLabel: UILabel! {
        didSet {
            episodeTitleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func playPauseButton(_ sender: UIButton!) {
        handlePlayPause()
    }
    
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    fileprivate func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playAndPauseButton.setImage(#imageLiteral(resourceName: "player-pause"), for: .normal)
        } else {
            player.pause()
            playAndPauseButton.setImage(#imageLiteral(resourceName: "player-play"), for: .normal)
        }
    }
}
