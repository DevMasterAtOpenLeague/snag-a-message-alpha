//
//  CommentService.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation

/**
 Creates fully initialized CommentBubble objects.
*/

let commentService = CommentService.sharedService

class CommentService {
    
    static let sharedService = CommentService()
    
    
    var currentCoversation: Conversation!
    var currentRecevicer: SnagUser!
    
    /*
        Private initializer for shared singleton instance.
    */
    private init() {
        
    }
    
    func setCurrentConversation(receiver: SnagUser){
        
        if userService.currentSnagUser.hasFriend(receiver) {
            if userService.currentSnagUser.allConversations.keys.contains(receiver) {
                if let converstation = userService.currentSnagUser.allConversations[receiver] {
                    if !converstation.expired {
                        currentCoversation = converstation
                    }
                }
            
            }
            
        }else{
            // Do nothing the receiver is not a friend of the current user.
        }
    }
    
}