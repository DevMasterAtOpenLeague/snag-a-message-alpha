//
//  MessageCollectionViewCell.swift
//  snag-a-message
//
//  Created by Romaine on 2/7/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var rightThumbnailImageView: UIImageView!
    @IBOutlet weak var messageBlurView: RoundedBlurEffectView!
    
    
    func roundThumbnailImageView(){
        
        if !self.rightThumbnailImageView.hidden{
            self.rightThumbnailImageView.layer.borderWidth = 1
            self.rightThumbnailImageView.layer.masksToBounds = false
            self.rightThumbnailImageView.layer.borderColor = UIColor.clearColor().CGColor
            self.rightThumbnailImageView.layer.cornerRadius = self.rightThumbnailImageView.frame.height / 2
            self.rightThumbnailImageView.clipsToBounds = true
        }else{
            self.thumbnailImageView.layer.borderWidth = 1
            self.thumbnailImageView.layer.masksToBounds = false
            self.thumbnailImageView.layer.borderColor = UIColor.clearColor().CGColor
            self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.height / 2
            self.thumbnailImageView.clipsToBounds = true
        }
        
    }
    
}
