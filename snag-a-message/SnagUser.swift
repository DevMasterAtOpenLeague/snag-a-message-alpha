//
//  SnagUser.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Parse

class SnagUser: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return SNAG_USER_CLASS_KEY
    }
    
    @NSManaged var user: PFUser
    @NSManaged var username: String
    
    ///Friends stored using username as key.
    @NSManaged var allFriends: [String:SnagUser]
    
    ///Messages stored using the receivers username as key.
    @NSManaged var allMessages: [String:CommentData]
    
    ///Identifies this User's encryptor id.
    @NSManaged var encryptorId: String?
    
    @NSManaged var iv: String?
    
    @NSManaged var secretKey: String?
    
    @NSManaged var allConversations: [SnagUser : Conversation]
    
    var friends: [SnagUser]{
        didSet{
            let last = self.friends.last
            if let user = last {
                self.allFriends[user.username] = user
            }
        }
    }
    
    var messages: [CommentData]{
        didSet{
            let last = self.messages.last
            if let message = last {
                self.allMessages[message.receiversUsername] = message
            }
        }
    }
    
    var conversations: [Conversation] {
        didSet {
            if let last = self.conversations.last {
                self.allConversations[last.receiver] = last
            }
        }
    }
    
    var friendsCount: Int {
        get {
            return self.friends.count
        }
    }
    
    var messageCount: Int {
        get {
            return self.messages.count
        }
    }
    
    override init() {
        self.friends = [SnagUser]()
        self.messages = [CommentData]()
        self.conversations = [Conversation]()
        super.init()
    }
    
    init(user: PFUser, withUsername username: String) {
        self.friends = [SnagUser]()
        self.messages = [CommentData]()
        self.conversations = [Conversation]()
        super.init()
        self.user = user
        self.username = username
    }
    
    func hasFriend(user: SnagUser) -> Bool {
        return self.hasFriend(withUsername: user.username)
    }
    
    func hasFriend(withUsername username: String) -> Bool {
        return allFriends.keys.contains(username)
    }
    
    func getFriendByUsername(username: String) -> SnagUser! {
        if hasFriend(withUsername: username) {
            if let user = self.allFriends[username] {
                return user
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    
    
    
}