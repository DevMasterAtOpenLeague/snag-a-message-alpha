//
//  CommentData.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Parse

class CommentData: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return COMMENTDATA_CLASSKEY
    }
    
    @NSManaged var sendersUsername: String
    @NSManaged var receiversUsername: String
    
    @NSManaged var encryptedMessage: String
    
    @NSManaged var encryptor_id: String
    
    @NSManaged var timeStamp: String
    
    var type: CommentDataType!
    
    override init() {
        super.init()
    }
    
    init(sender: SnagUser, receiver: SnagUser, message: String) {
        super.init()
        if let id = sender.encryptorId{
            self.sendersUsername = sender.username
            self.receiversUsername = receiver.username
            self.encryptor_id = id
            let encryptedBytes = userService.encryptMessage(sender, message: message)
            self.encryptedMessage = String(encryptedBytes)
            self.timeStamp = NSDate().formattedTimestamp
        }
    }
    
    func decrypt() -> String {
        if let id = userService.currentSnagUser.encryptorId {
            if id == self.encryptor_id {
                self.type = .Mine
                return userService.decryptMessage(userService.currentSnagUser, encryptedBytes: self.encryptedMessage.toUInt8Array())
            }else
                if let user = userService.currentSnagUser.getFriendByUsername(receiversUsername) {
                    if let id = user.encryptorId {
                        if id == self.encryptor_id {
                            self.type = .Opponent
                            return userService.decryptMessage(user, encryptedBytes: self.encryptedMessage.toUInt8Array())
                        }
                    }
            }
                    
            }
            return "failed-decrypt"
        }
    
    
}
