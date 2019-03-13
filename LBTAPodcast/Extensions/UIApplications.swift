//
//  UIApplications.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 13/03/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
