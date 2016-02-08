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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(messageViewCellId, forIndexPath: indexPath) as! MessageCollectionViewCell
        
        let data = CommentBubbleData(text: "First comment data!!!", image: nil, date: NSDate(), type: .Opponent)
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
