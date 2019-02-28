//
//  String.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 28/02/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https" )
    }
}
