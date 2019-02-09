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
    
    struct Episode {
        let title: String
    }
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWork()
    }
    
    fileprivate func fetchEpisodes(){
        guard let feedUrl = podcast.feedUrl else { return }
        guard let url = URL(string: feedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            switch result {
            case let .rss(feed):
                var episodes = [Episode]()
                feed.items?.forEach({ (feedItem) in
                    episodes.append(Episode(title: feedItem.title ?? ""))
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK:- Setup TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = episodes[indexPath.row].title
        cell.textLabel?.numberOfLines = -1
        return cell
    }
}
