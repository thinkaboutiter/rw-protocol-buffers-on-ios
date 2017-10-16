//
//  contact+extensions.swift
//  RWCards
//
//  Created by boyankov on W42 16/Oct/2017 Mon.
//  Copyright © 2017 boyankov@yahoo.com. All rights reserved.
//

import Foundation

extension Contact {
    
    func contactTypeToString() -> String {
        let retval: String
        
        switch self.type {
        case .speaker:
            retval = "SPEAKER"
            
        case .attendant:
            retval = "ATTENDEE"
            
        case .volunteer:
            retval = "VOLUMTEER"
            
        default:
            retval = "UNKNOWN"
        }
        return retval
    }
}
