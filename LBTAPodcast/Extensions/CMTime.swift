//
//  CMTime.swift
//  LBTAPodcast
//
//  Created by Daniel Aditya Istyana on 05/03/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import AVKit

extension CMTime {
    func toStringFormat() -> String {
        
        if CMTimeGetSeconds(self).isNaN { return "--:--" }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        
        let timeFormatString = String(format: "%02d%:%02d%", minutes, seconds)
        return timeFormatString
    }
}
