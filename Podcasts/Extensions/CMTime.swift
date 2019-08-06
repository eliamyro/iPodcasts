//
//  CMTime.swift
//  Podcasts
//
//  Created by Elias Myronidis on 06/08/2019.
//  Copyright © 2019 eliamyro. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let hours = minutes / 60
        let timeFormatString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        return timeFormatString
    }
}
