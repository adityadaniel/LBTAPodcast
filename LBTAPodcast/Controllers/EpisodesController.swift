//
//  EpisodesController.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 31/01/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    let cellId = "cellId"
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName ?? ""
            fetchEpisodes()
        }
    }

    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWork()
    }
    
    fileprivate func fetchEpisodes(){
        guard let feedUrl = podcast.feedUrl else { return }
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            switch result {
            case let .rss(feed):
                var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    episodes.append(Episode(feedItem: feedItem))
                })
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            default:
                break
            }
            
        }
    }
    
    //MARK:- Setup Work
    fileprivate func setupWork() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- Setup TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        return cell
    }
}
