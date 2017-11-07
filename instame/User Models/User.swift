//
//  User.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation
import UIKit

open class User {
    
    // Keys matching api endpoints for easy reference
    var username : String? = nil
    var profile_picture : URL? = nil
    var full_name : String? = nil
    var id : String? = nil
    var bio : String? = nil
    var website : String? = nil
    var counts : UserCounts = UserCounts()
    
    
    // Other User items
    var relationships : [String:[User]] = [ "Follows" : [], "Followed By" : []]
    var profileImage : UIImage? = nil {
        didSet {
            if let avatar = profileImage {
                NotificationCenter.default.post(name: Notification.Name(rawValue:"UserAvatarUpdate"), object: avatar)
            }
        }
    }
    
    public init?( _ dict : [String:Any]? ) {
        
        // Catch failed attempts from sugar init
        guard let jsonDict = dict
            else {
                print("No user dictionary provided. Could not create user.")
                return
        }
        
        
        // Enforce expected formatting
        guard
            let _username = jsonDict["username"] as? String,
            let _profile_picture_string = jsonDict["profile_picture"] as? String,
            let _profile_picture = URL(string:_profile_picture_string),
            let _full_name = jsonDict["full_name"] as? String,
            let _id = jsonDict["id"] as? String,
            let _website = jsonDict["website"] as? String,
            let _counts = jsonDict["counts"] as? [String:Int]
        
                else {
                    print("Items required to create user not present. Could not create user. ( username, profile_picture, full_name & id )")
                    return nil
        }
        
        // Set user data
        self.username = _username
        self.profile_picture = _profile_picture
        self.full_name = _full_name
        self.id = _id
        self.website = _website
        self.counts = UserCounts(_counts)
        
        InstaFetch().fetchImage(self.profile_picture!)
            .success { ( image : Any ) in
                self.profileImage = image as? UIImage
            }
            .error { ( error : String ) in
                print("Failed fetching profile image picture : \(error)")
            }
        
        

    }

}
