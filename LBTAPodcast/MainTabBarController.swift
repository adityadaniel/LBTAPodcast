//
//  MainTabBarController.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/12/18.
//  Copyright © 2018 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        
        // make all navbar have large titles
        UINavigationBar.appearance().prefersLargeTitles = true
        
        // run setup on all view controllers
        setupViewControllers()
        
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
