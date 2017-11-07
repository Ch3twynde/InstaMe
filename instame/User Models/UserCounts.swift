//
//  UserCounts.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation

open class UserCounts {
    
    var media : Int = 0
    var follows : Int = 0
    var followed_by : Int = 0
    
    convenience init () {
        self.init(nil)
    }
    
    init ( _ countsJson : [String:Int]? ) {
        
        guard let counts = countsJson
            else {
                
                // Return zeros for all counts
                return
        }
        
        self.media = counts["media"] ?? 0
        self.follows = counts["follows"] ?? 0
        self.followed_by = counts["followed_by"] ?? 0
    }
}
