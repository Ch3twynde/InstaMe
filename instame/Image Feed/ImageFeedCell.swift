//
//  ImageFeedCell.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import UIKit

class ImageFeedCell: UITableViewCell {

    // Media image
    @IBOutlet var mediaImage : UIImageView!
    
    // Huggie Bear
    @IBOutlet var bear : UIImageView!
    var initialBearFrame : CGRect? = CGRect.zero
    var hiddenBearFrame : CGRect? = CGRect.zero
    
    // Text
    @IBOutlet var caption : UILabel!
    
    var feedImage : FeedImage? = nil
    var onDoubleTap : (() -> Void)?
    
    @objc func doubleTap ( sender : Any ) {
        
        if let dt = self.onDoubleTap {
            dt()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.initialBearFrame = self.bear.frame
        self.hiddenBearFrame = CGRect(x:0, y:-self.bear.frame.size.height, width : self.bear.frame.size.width, height : self.bear.frame.size.height )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
