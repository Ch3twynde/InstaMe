//
//  InstaApiUrls.swift
//  instame
//
//  Created by Miles Alden on 11/6/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation


open class InstaApiUrl {
    
    open var basePath : String {
        get {
            return InstaApi.shared.basePath
        }
    }
    open var access_token : String {
        get {
            return InstaApi.shared.access_token ?? ""
        }
    }
    
    /**
     Overloads for full url generation of endpoints
     */
    open func fullUrl ( _ endpoint : UserEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : UserEndpoints, userId : String? ) -> URL? {
        guard let id = userId
            else {
                print ("Missing user id.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<USER_ID>", with: id)
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Relationship Gen
     */
    open func fullUrl ( _ endpoint : RelationshipEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : RelationshipEndpoints, userId : String? ) -> URL? {
        guard let id = userId
            else {
                print ("Missing user id.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<USER_ID>", with: id)
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Media gen
     */
    open func fullUrl ( _ endpoint : MediaEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : MediaEndpoints, mediaId : String? ) -> URL? {
        
        guard let id = mediaId
            else {
                print ("Missing media id.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<MEDIA_ID>", with: id)
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : MediaEndpoints, shortcode : String? ) -> URL? {
        
        guard let short = shortcode
            else {
                print ("Missing shortcode.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<SHORTCODE>", with: short)
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Comment gen
     */
    open func fullUrl ( _ endpoint : CommentEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : CommentEndpoints, mediaId : String? ) -> URL? {
        
        guard let id = mediaId
            else {
                print ("Missing media id.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<MEDIA_ID>", with: id)
        
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : CommentEndpoints, mediaId : String?, commentId : String? ) -> URL? {
        
        guard let id = mediaId, let comId = commentId
            else {
                print ("Missing media or comment id")
                return fullUrl(endpoint)
        }
        
        var withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<MEDIA_ID>", with: id)
        withId = NSString(string:withId).replacingOccurrences(of: "<COMMENT_ID>", with: comId)
        
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Like gen
     */
    open func fullUrl ( _ endpoint : LikeEndpoints, mediaId : String? ) -> URL? {
        
        guard let id = mediaId
            else {
                print ("Missing media id.")
                return nil
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<MEDIA_ID>", with: id)
        
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Tags gen
     */
    open func fullUrl ( _ endpoint : TagEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : TagEndpoints, tagName : String? ) -> URL? {
        
        guard let name = tagName
            else {
                print ("Missing tag name.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<TAG_NAME>", with: name)
        
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
    /**
     Locations gen
     */
    open func fullUrl ( _ endpoint : LocationEndpoints ) -> URL? {
        return URL(string:basePath + endpoint.rawValue + "/?access_token=\(self.access_token)")
    }
    open func fullUrl ( _ endpoint : LocationEndpoints, locationId : String? ) -> URL? {
        
        guard let loc = locationId
            else {
                print ("Missing location id.")
                return fullUrl(endpoint)
        }
        
        let withId = NSString(string:endpoint.rawValue).replacingOccurrences(of: "<LOCATION_ID>", with: loc)
        
        return URL(string:basePath + withId + "/?access_token=\(self.access_token)")
    }
    
    
}
