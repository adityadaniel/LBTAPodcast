//
//  PodcastsSearchController.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/01/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit
import Alamofire


class PodcastsSearchController: UITableViewController, UISearchBarDelegate  {
    
    let cellId = "cellID"
    
    var podcasts = [Podcast]()

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
    }
    
    
    //MARK:- TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search query"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.podcasts.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodesController = EpisodesController()
        let podcast = self.podcasts[indexPath.row]
        episodesController.podcast = podcast
        navigationController?.pushViewController(episodesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    //MARK:- Search function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(with: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
       
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
}
