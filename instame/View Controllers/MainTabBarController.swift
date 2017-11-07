//
//  MainTabBarController.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Auto updating mechanism for avatar image once downloaded
        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.updateAvatarImage(notification:)), name: NSNotification.Name(rawValue:"UserAvatarUpdate"), object: nil)
        
        // Fetch user info
        InstaApi.shared.getUserInfo { (data : [String:Any] ) in

            // Make mutable and strip "meta"
            let d = data["data"] as? [String:Any]
            
            let me = User(d)
            print ("Received : \(me)")
            
            InstaApi.shared.getRecentUserPosts(callback: { (recentPosts : [String:Any] ) in
                
                guard let postData = recentPosts["data"] as? [[String:Any]]
                    else {
                        print("Malformed data")
                        return
                }
                
                for entry in postData {
                    
                    
                    guard let e = entry as? [String:Any]
                        else {
                            print("Malformed entry")
                            break
                    }
                    
                    guard let likes = e["likes"] as? [String:Int]
                        else {
                            print("Malformed likes")
                            break
                    }
                    
                    guard let images = e["images"] as? [String:Any]
                        else {
                            print("Malformed images")
                            break
                    }
                    
                    guard let caption = e["caption"] as? [String:Any]
                        else {
                            print("Malformed caption")
                            break
                    }
                    
                    guard let mediaId = e["id"] as? String
                        else {
                            print("Malformed media id")
                            break
                    }
                    
                    
                    if let standardRes = images["standard_resolution"] as? [String:Any] {
                        let feedImage = FeedImage(url: standardRes["url"] as! String, liked: Bool(likes["count"]! > 0), caption : caption["text"] as? String )
                        feedImage.mediaId = mediaId
                        
                        (self.selectedViewController! as! ImageFeedController).feedImages.append(feedImage)
                    }
                    
                }
                
                DispatchQueue.main.async {
                    (self.selectedViewController! as! ImageFeedController).tableView.reloadData()
                }
                
            })
        }
    }
    
    /**
     @TODO
     */
    @objc func updateAvatarImage ( notification : Notification ) {
    
        
    }
    
    @objc func userProfileTapped ( _ sender : Any ) {
        print("User item tapped")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
