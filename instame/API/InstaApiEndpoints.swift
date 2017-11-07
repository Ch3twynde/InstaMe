//
//  InstaApiEndpoints.swift
//  instame
//
//  Created by Miles Alden on 11/6/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation


/**
 User endpoints
 @note <USER_ID> to be replaced with an actual user id
 @note https://www.instagram.com/developer/endpoints/users/
 */
public enum UserEndpoints : String {
        
    /**
     Get information about the owner of the access token
     @note GET
     */
    case me = "/users/self"
    
    /**
     Get information about a user
     @note GET
     */
    case user_id = "/users/<USER_ID>"
    
    /**
     Get the most recent media of the user
     @note GET
     */
    case media_recent = "/users/self/media/recent"
    
    /**
     Get the recent media liked by the user
     @note GET
     */
    case media_liked = "/users/<USER_ID>/media/liked"
    
    /**
     Search for a user by name
     @note GET
     */
    case search = "/users/search"
}


/**
 Relationship endpoints
 @note <USER_ID> to be replaced with an actual user id
 @note https://www.instagram.com/developer/endpoints/relationships/
 */
public enum RelationshipEndpoints : String {
    
    /**
     Get the list of users this user follows
     @note GET
     */
    case follows = "/users/self/follows"
    
    /**
     Get the list of users this user is followed by
     @note GET
     */
    case followed_by = "/users/self/followed-by"
    
    /**
     List the users who have requested to follow
     @note GET
     */
    case requested_by = "/users/self/requested-by"
    
    /**
     Get the recent media liked by the user or
     Modify the relationship with target usr
     @note GET and POST
     */
    case relationship = "/users/<USER_ID>/relationship"
    
}


/**
 Media endpoints
 @note <MEDIA_ID> and <SHORTCODE> to be replaced with an actual values
 @note https://www.instagram.com/developer/endpoints/media/
 */
public enum MediaEndpoints : String {
    
    
    /**
     Get information about a media object
     @note GET
     */
    case media_info = "/media/<MEDIA_ID>"
    
    /**
     Get information about a media object using shortcode
     @note GET
     */
    case shortcode = "/media/<SHORTCODE>"
    
    /**
     Search for recent media in a given area
     @note GET
     */
    case search = "/media/search"
}


/**
 Comment endpoints
 @note <MEDIA_ID> and <COMMENT_ID> to be replaced with an actual values
 @note https://www.instagram.com/developer/endpoints/comments/
 */
public enum CommentEndpoints : String {
    
    /**
     Get information about a media object or
     Create a new comment on a media object
     @note GET or POST
     */
    case comments = "/media/<MEDIA_ID>/comments"


    /**
     Remove a comment
     @note DEL
     */
    case remove = "/media/<MEDIA_ID>/comments/<COMMENT_ID>"
}


/**
 Like endpoints
 @note <MEDIA_ID> to be replaced with an actual values
 @note https://www.instagram.com/developer/endpoints/likes/
 */
public enum LikeEndpoints : String {
    
    /**
     Get a list of users who have liked this media or
     Set a like on this media by the current user or
     Remove a like on this media by the current user
     
     @note GET, POST, DEL
     */
    case likes = "/media/<MEDIA_ID>/likes"

}


/**
 Tag endpoints
 @note <TAG_NAME> to be replaced with an actual values
 @note https://www.instagram.com/developer/endpoints/tags/
 */
public enum TagEndpoints : String {
    
    /**
     Get information about a tag object
     @note GET
     */
    case tag = "/tags/<TAG_NAME>"
    
    
    /**
     Get a list of recently tagged media
     @note GET
     */
    case recent = "/tags/<TAG_NAME>/media/recent"
    
    
    /**
     Get a list of recently tagged media
     @note GET
     */
    case search = "/tags/search"
}



/**
 Location endpoints
 @note <LOCATION_ID> to be replaced with an actual values
 @note https://www.instagram.com/developer/endpoints/locations/
 */
public enum LocationEndpoints : String {
    
    /**
     Get information about a tag object
     @note GET
     */
    case location = "/locations/<LOCATION_ID>"
    
    
    /**
     Get a list of recently tagged media
     @note GET
     */
    case recent = "/locations/<LOCATION_ID>/media/recent"
    
    
    /**
     Get a list of recently tagged media
     @note GET
     */
    case search = "/locations/search"
}
