//
//  InstaApi.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation


// Callback standard
public typealias JsonCallback = ([String:Any]) -> Void


open class InstaApi {
    
    /**
     Singleton instance
     */
    fileprivate static let sharedInstance = InstaApi()

    /**
     Singleton accessor
     */
    open class var shared : InstaApi {
        return sharedInstance
    }
    
    
    var access_token : String? = nil
    let basePath = "https://api.instagram.com/v1"
    let urls = InstaApiUrl()
    
    
    
    /**
     Fetch info about current user
     @param callback JsonCallback passing a json string from our response data
     */
    open func getUserInfo ( callback : @escaping JsonCallback ) {
        
        let url = self.urls.fullUrl( .me )!
        InstaFetch().jsonFetch(url)
            .success { ( json : Any ) in
                callback((json as? [String:Any])!)
            }
            .error { ( error : String ) in
                print(error)
                callback([:])
            }

    }
    
    
    /**
     Fetch recently posted media
     @param callback JsonCallback passing a json string from our response data
     @warning Pulls EVERY item in the list? This must have a min-max value that can be used.
     */
    open func getRecentUserPosts ( callback : @escaping JsonCallback ) {
        
        let url = self.urls.fullUrl( UserEndpoints.media_recent )!
        InstaFetch().jsonFetch(url)
            .success { ( json : Any ) in
                callback((json as? [String:Any])!)
            }
            .error { ( error : String ) in
                print(error)
                callback([:])
        }
        
    }
    

    /**
     Post like for media item
     */
    open func postLike ( mediaId : String, callback : JsonCallback? ) {
        
        guard let url = self.urls.fullUrl( LikeEndpoints.likes, mediaId : mediaId )
            else {
                print("Error generating likes url.")
                return
        }
        
        InstaFetch().post(url)
            .success { ( json : Any ) in
                if let cb = callback {
                    cb((json as? [String:Any])!)
                }
            }
            .error { ( error : String ) in
                print(error)
                if let cb = callback {
                    cb([:])
                }
        }
        
    }
    
    /**
     Post like for media item
     */
    open func removeLike ( mediaId : String, callback : JsonCallback? ) {
        
        guard let url = self.urls.fullUrl( LikeEndpoints.likes, mediaId : mediaId )
            else {
                print("Error generating likes url.")
                return
        }
        
        InstaFetch().delete(url)
            .success { ( json : Any ) in
                if let cb = callback {
                    cb((json as? [String:Any])!)
                }
            }
            .error { ( error : String ) in
                print(error)
                if let cb = callback {
                    cb([:])
                }
        }
        
    }
}
