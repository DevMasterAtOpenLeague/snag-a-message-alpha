//
//  Conversation.swift
//  snag-a-message
//
//  Created by OL_vmox on 2/8/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Parse

class Conversation: PFObject, PFSubclassing {
    
    static let className: String = "conversationClassName"
    
    class func parseClassName() -> String {
        return className
    }
    
    @NSManaged var sender: SnagUser
    @NSManaged var receiver: SnagUser
    @NSManaged var createdTimeStamp: String
    @NSManaged var expiredTimeStamp: String
    @NSManaged var modifiedTimeStamp: String
    
    var expired: Bool {
        get {
            return NSDate.isExpired(timeStamp: self.expiredTimeStamp)
        }
    }
    
    var initial: Bool = true
    //The Int key's value should only be 0 or 1. Indicating who encrypted the message, O for sender and 1 for receiver.
    @NSManaged private var messages: [Int : [CommentData]]
    
    private var allMessages: [CommentData] {
        
        didSet {
            if !initial {
                if let last = self.allMessages.last {
                    if last.encryptor_id == self.sender.encryptorId {
                        if !self.containsMessage(0, message: last) {
                            self.messages[0]?.append(last)
                        }
                    }else{
                        if !self.containsMessage(1, message: last) {
                            self.messages[1]?.append(last)
                        }
                    }
                }
            }
        }
    }
    var messageCount: Int {
        get {
            return self.messages[0]!.count + self.messages[1]!.count
        }
    }
    
    override init() {
        self.allMessages = [CommentData]()
        super.init()
    }
    
    init(receiver: SnagUser) {
        self.allMessages = [CommentData]()
        super.init()
        self.receiver = receiver
        self.sender = userService.currentSnagUser
        self.createdTimeStamp = NSDate().formattedTimestamp
        self.modifiedTimeStamp = NSDate().formattedTimestamp
        self.messages[0] = [CommentData]()
        self.messages[1] = [CommentData]()
    }
    
    
    func addMessage(message: CommentData) -> Bool {
        
        if !expired {
            allMessages.append(message)
            return true
        }else{
            return false
        }
        
       
    }
    
    func getAllMessages() -> [CommentData] {
        if initial {
            if let senderMessages = self.messages[0] {
                if let receiverMessages = self.messages[1] {
                    self.allMessages = senderMessages + receiverMessages
                    self.initial = false
                }
            }
        }
        
        if !expired {
            return self.allMessages
        }else{
            return [CommentData]()
        }
    }
    
    
    private func containsMessage(key: Int, message: CommentData) -> Bool {
        switch key {
        case 0:
            let found = messages[0]?.filter { $0.timeStamp == message.timeStamp }
            return found?.count > 0
            
        case 1:
            let found = messages[1]?.filter { $0.timeStamp == message.timeStamp }
            return found?.count > 0
            
        default:
            return false
        }
    }
    
    
    
}
