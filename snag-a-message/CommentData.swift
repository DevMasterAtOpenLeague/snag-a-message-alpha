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
}
