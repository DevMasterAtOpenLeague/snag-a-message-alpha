//
//  SnagCache.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation

/**
SnagCache caches all the recevier User objects this sender sent a message to.
 It also caches CommentBubbleData that isn't marked for destruction.
 
*/
final class SnagCache {
    
    private var cache: NSCache
    
    static let sharedCache = SnagCache()
    
    private init(){
        self.cache = NSCache()
    }
    
    func setAttributesForMessage(message: CommentBubbleData, sender: SnagUser, receiver: SnagUser) {
        let attributes = [
            CACHE_SENDER_KEY: sender,
            CACHE_RECEIVER_KEY: receiver,
            CACHE_MESSAGE_KEY: message
        ]
        setAttributes(attributes as! [String:AnyObject], forUser: sender)
    }
    
    
    func setAttributes(attributes: [String:AnyObject], forUser user: SnagUser){
        let key: String = self.userKey(user)
        cache.setObject(attributes, forKey: key)
    }
    
    func userKey(user: SnagUser) -> String {
        return "snag-user_\(user.objectId)"
    }
}