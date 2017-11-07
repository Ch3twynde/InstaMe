//
//  FirstViewController.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import UIKit

class ImageFeedController : UITableViewController {

    var feedImages : [FeedImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cellNib = UINib(nibName: "ImageFeedCell", bundle: nil)
        self.tableView?.register(cellNib, forCellReuseIdentifier: "ImageFeedCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedImages.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ImageFeedCell = tableView.dequeueReusableCell(withIdentifier: "ImageFeedCell", for: indexPath) as! ImageFeedCell
        
        // Pull feed image for current row
        let feedImage = self.feedImages[indexPath.row]
        
        // Async fetch image
        InstaFetch().fetchImage(feedImage.imageUrl)
            .success { ( image : Any ) in
                DispatchQueue.main.async {
                    
                    // Link cell and feed image
                    cell.feedImage = feedImage
                    
                    // Update image
                    cell.mediaImage.contentMode = UIViewContentMode.scaleAspectFit
                    cell.mediaImage.clipsToBounds = true
                    cell.mediaImage.image = image as? UIImage
                    
                    // Hide liked bear image
                    cell.bear.alpha = feedImage.liked ? 1 : 0

                    // Set caption text
                    cell.caption.text = feedImage.caption
                    
                    // Double tap handler
                    let doubleTap = UITapGestureRecognizer(target: cell, action: #selector(ImageFeedCell.doubleTap(sender:)))
                    doubleTap.numberOfTapsRequired = 2
                    
                    cell.addGestureRecognizer(doubleTap)
                    
                    // Closure for double tap behavior
                    cell.onDoubleTap = { () in
                        
                        feedImage.liked = !feedImage.liked
                        
                        if feedImage.liked {
                            InstaApi.shared.postLike(mediaId: feedImage.mediaId, callback: nil)
                        } else {
                            InstaApi.shared.removeLike(mediaId: feedImage.mediaId, callback: nil)
                        }
                        
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                            
                            if feedImage.liked {
                                cell.bear.bounds = cell.initialBearFrame!
                                cell.bear.alpha = feedImage.liked ? 1 : 0
                            } else {
                                cell.bear.bounds = cell.hiddenBearFrame!
                                cell.bear.alpha = feedImage.liked ? 1 : 0
                            }
                            
                        }, completion: nil)
                    }

                }
            }
            .error { ( error : String ) in
                print("Failed fetching profile image picture : \(error)")
        }
                
        return cell
    }

}

