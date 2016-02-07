//
//  CommentBubbleData.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation
import UIKit


/**
 **CommentDataType**
 Enum specifing the type or direction of the comment bubble location.
 
 *Useage*
 - Mine:     Chat message is outgoing
 - Opponent: Chat message is incoming
*/
enum CommentDataType: Int{
    case Mine = 0
    case Opponent
}

/**
DataModel for maintaining the message data for a single chat bubble
*/
class CommentBubbleData {
    
    /// Actual Cleartext Message
    var text: String?
    
    /// Optional Image data
    var image: UIImage?
    
    /// Data used as a timestamp
    var date: NSDate?
    
    /// The type of this comment
    var type: CommentDataType
    
    /**
     Default initializer.
     *Useage*
     
    */
    init(text: String?,image: UIImage?,date: NSDate? , type:CommentDataType = .Mine) {
        // Default type is Mine
        self.text = text
        self.image = image
        self.date = date
        self.type = type
    }
}
