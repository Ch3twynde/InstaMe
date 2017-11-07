//
//  FeedImage.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation


open class FeedImage {
    
    open var imageUrl : URL
    open var liked : Bool
    open var caption : String
    open var mediaId : String
    
    init ( url : String, liked : Bool, caption : String? ) {
        self.imageUrl = URL(string:url)!
        self.liked = liked
        self.caption = caption ?? ""
        self.mediaId = "-1"
    }
    
    open func like () {
        liked = !liked
    }
    
}
