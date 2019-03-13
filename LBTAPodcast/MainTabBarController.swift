//
//  MainTabBarController.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/12/18.
//  Copyright © 2018 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let playerDetailsView = PlayerDetailViews.initFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        
        // make all navbar have large titles
        UINavigationBar.appearance().prefersLargeTitles = true
        
        // run setup on all view controllers
        setupViewControllers()
        
        setupPlayerDetailsView()
        
    }
    
    @objc func minimizePlayerDetails() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform.identity
        })
        self.playerDetailsView.miniPlayerView.alpha = 1
        self.playerDetailsView.maximizedStackView.alpha = 0
    }
    
    func maximizePlayerDetails(episode: Episode?) {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        // Check if episode is not nil to prevent crashing the app
        if episode != nil {
            playerDetailsView.episode = episode
        }
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(scaleX: 0, y: 100)
            self.playerDetailsView.miniPlayerView.alpha = 0
            self.playerDetailsView.maximizedStackView.alpha = 1
        })
    }
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsView() {
    
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        // use autolayout
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // autolayout constraint
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorConstraint.isActive = true

        bottomAnchorConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true

        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64).isActive = true
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    //MARK:- Setup all view controllers
    func setupViewControllers() {
        viewControllers = [
            generateNavigationController(with: PodcastsSearchController(), title: "Search", imageName: "Search"),
            generateNavigationController(with: ViewController(), title: "Favorites", imageName: "Style"),
            generateNavigationController(with: ViewController(), title: "Downloads", imageName: "Album")
        ]
    }
    
    
    //MARK:- Helper functions to generate view controllers
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, imageName: String) -> UIViewController {
    
        let vc = UINavigationController(rootViewController: rootViewController
        )
        vc.tabBarItem.title = title
        vc.navigationBar.topItem?.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        return vc
    }
    
}
