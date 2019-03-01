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
    var episodes = [Episode]()
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName ?? ""
            fetchEpisodes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWork()
    }
    
    fileprivate func fetchEpisodes(){
        guard let feedUrl = podcast.feedUrl else { return }
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ep = self.episodes[indexPath.row]
        
        let window = UIApplication.shared.keyWindow
        let playerDetailViews = Bundle.main.loadNibNamed("PlayerDetailViews", owner: self, options: nil)?.first as! PlayerDetailViews
        
        playerDetailViews.episode = ep
        
        playerDetailViews.frame = self.view.frame
        window?.addSubview(playerDetailViews)
    }
    
    
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
