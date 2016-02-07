//
//  CommentBubble.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

/**
Comment chat bubble UIView

*/
class CommentBubble: UIView {
    
   
    var imageViewChat: UIImageView?
    var imageViewBG: UIImageView?
    var text: String?
    var labelChatText: UILabel?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    /**
     Initializes a chat bubble view
     
     :param: data   ChatBubble Data
     :param: startY origin.y of the chat bubble frame in parent view
     
     :returns: Chat Bubble
     */
    init(data: CommentBubbleData, startY: CGFloat){
        
        
        super.init(frame: CommentBubble.framePrimary(data.type, startY:startY))
        
        
        self.backgroundColor = UIColor.lightGrayColor()
        
        let padding: CGFloat = 10.0
        
        
        if let chatImage = data.image {
            
            let width: CGFloat = min(chatImage.size.width, CGRectGetWidth(self.frame) - 2 * padding)
            let height: CGFloat = chatImage.size.height * (width / chatImage.size.width)
            imageViewChat = UIImageView(frame: CGRectMake(padding, padding, width, height))
            imageViewChat?.image = chatImage
            imageViewChat?.layer.cornerRadius = 5.0
            imageViewChat?.layer.masksToBounds = true
            self.addSubview(imageViewChat!)
        }
        
        
        if let chatText = data.text {
           
            let startX = padding
            var startY:CGFloat = 5.0
            if let imageView = imageViewChat {
                startY += CGRectGetMaxY(imageView.frame)
            }
            labelChatText = UILabel(frame: CGRectMake(startX, startY, CGRectGetWidth(self.frame) - 2 * startX , 5))
            labelChatText?.textAlignment = data.type == .Mine ? .Right : .Left
            labelChatText?.font = UIFont.systemFontOfSize(14)
            labelChatText?.numberOfLines = 0
            labelChatText?.text = chatText
            labelChatText?.sizeToFit()
            self.addSubview(labelChatText!)
        }
        
        var viewHeight: CGFloat = 0.0
        var viewWidth: CGFloat = 0.0
        if let imageView = imageViewChat {
            
            viewWidth = max(CGRectGetMaxX(imageView.frame), CGRectGetMaxX(labelChatText!.frame)) + padding
            viewHeight = max(CGRectGetMaxY(imageView.frame), CGRectGetMaxY(labelChatText!.frame)) + padding
            
        } else {
            viewHeight = CGRectGetMaxY(labelChatText!.frame) + padding/2
            viewWidth = CGRectGetWidth(labelChatText!.frame) + CGRectGetMinX(labelChatText!.frame) + padding
        }
        
        
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), viewWidth, viewHeight)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - FRAME CALCULATION
    class func framePrimary(type:CommentDataType, startY: CGFloat) -> CGRect{
        let paddingFactor: CGFloat = 0.02
        let sidePadding = ScreenSize.SCREEN_WIDTH * paddingFactor
        let maxWidth = ScreenSize.SCREEN_WIDTH * 0.65 // We are cosidering 65% of the screen width as the Maximum with of a single bubble
        let startX: CGFloat = type == .Mine ? ScreenSize.SCREEN_WIDTH * (CGFloat(1.0) - paddingFactor) - maxWidth : sidePadding
        return CGRectMake(startX, startY, maxWidth, 5) // 5 is the primary height before drawing starts
    }
}

struct ScreenSize {
    
    static var SCREEN_WIDTH: CGFloat = 420.0
}
