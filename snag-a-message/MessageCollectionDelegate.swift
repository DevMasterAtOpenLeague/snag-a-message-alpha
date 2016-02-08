//
//  MessageCollectionDelegate.swift
//  snag-a-message
//
//  Created by Romaine on 2/7/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

class MessageCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    
}

class MessageCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    ///DataSource provider.
    var commentService: CommentService = CommentService.sharedService
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentService.currentCoversation.messageCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(messageViewCellId, forIndexPath: indexPath) as! MessageCollectionViewCell
        
        let commentData = commentService.currentCoversation.getAllMessages()[indexPath.row]
        
        let data = CommentBubbleData(text: commentData.decrypt(), image: nil, date: NSDate(), type: commentData.type)
        let commentBubble = CommentBubble(data: data, startY: 25)
        commentBubble.cornerRadius = 5

        if data.type == .Mine {
            cell.thumbnailImageView.hidden = false
            cell.rightThumbnailImageView.hidden = true
        }else{
            cell.thumbnailImageView.hidden = true
            cell.rightThumbnailImageView.hidden = false
        }
        
        cell.messageBlurView.addSubview(commentBubble)
        cell.roundThumbnailImageView()
        
        return cell
    }
}
