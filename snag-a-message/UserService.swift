//
//  UserService.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation
import CryptoSwift
import Parse

let userService: UserService = UserService.sharedService

class UserService {
    
    static let sharedService = UserService()
    
    var currentUser: PFUser!
    var currentSnagUser: SnagUser!
    
    private init(){
        
    }
    
    func setCurrentReceiver(username: String) {
        
        if currentSnagUser.hasFriend(username) {
            let user: SnagUser = currentSnagUser.getFriendByUsername(username)
            let query = PFQuery(className: SNAG_USER_CLASS_KEY)
            query.getObjectInBackgroundWithId(user.objectId!, block: {
                (user, error) -> Void in
                if error == nil {
                    if let user = user as? SnagUser {
                        commentService.currentRecevicer = user
                    }
                }
            })
        }
        
    }
    
    func loadCurrentSnagUser() {
        let query = PFQuery(className: SNAG_USER_CLASS_KEY)
        query.whereKey(SNAG_USER_USERNAME_KEY, equalTo: self.currentUser.username!)
        do{
            self.currentSnagUser = try query.getFirstObject() as! SnagUser
            print("Found a matching SnagUser object.")
        }catch{
            print("Failed to locate a SnagUser with user object: \(currentUser)")
        }
    }
    
    func createUserAccount(user: SnagUser) -> SnagUser {
        if userExists(user.username) {
            print("User Account already exists.")
            return user
        }
        
        let secretWord = UInt8Word()
        let ivWord = UInt8Word()
        
        user.secretKey = secretWord.word
        user.iv = ivWord.word
        user.encryptorId = NSUUID().UUIDString
        
        do{
            try user.user.signUp()
            
        }catch{
            print("Failed to sign Up newly created User Account")
        }
        
        do{
            try user.save()
        }catch{
            print("Failed to save newly created User Account")
        }
        return user
    }
    
    func generate(size: Int) -> String {
        return RandomWord.generate(size)
    }
    
    func generate() -> String {
        var str = generate(175)
        str = str + NSDate().formattedTimestamp
        str = str.shuffle()
        let word = UInt8Word(word: str)
        return word.word!
        
    }
    
    func encryptMessage(user: SnagUser, message: String) -> [UInt8] {
        do {
            let encrypted = try AES(key: user.secretKey!, iv: user.iv!).encrypt(message.toUInt8Array())
            return encrypted
        }catch{
            assertionFailure("Failed to encrypt the given message.")
        }
        return [UInt8]()
    }
    
    func decryptMessage(user: SnagUser, encryptedBytes: [UInt8])  -> String {
        do {
            let decrypted = try AES(key: user.secretKey!, iv: user.iv!).decrypt(encryptedBytes)
            var str: String = ""
            str = str.bytesToString(decrypted)
            return str
        }catch{
           assertionFailure("Failed to decrypt the given message.")
        }
        
        return "decrypt-failed"
    }
        
    func bytesToString(bytes: [UInt8]) -> String {
        let data = NSData(bytes: bytes)
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
            return str
        }else{
            return "nil"
        }
    }
    
    func userExists(username: String) -> Bool {
        let query = PFQuery(className: SNAG_USER_CLASS_KEY)
        query.whereKey(SNAG_USER_USERNAME_KEY, equalTo: username)
        
        do {
            let user = try query.getFirstObject() as? SnagUser
            if user != nil {
                return true
            }else{
                return false
            }
        }catch {
            return false
        }
    }
    
    func encryptorId(forUser user: SnagUser) -> String {
        
        if user.encryptorId == nil {
            let clearId: String = user.username + NSDate().formattedTimestamp
            user.encryptorId = clearId
            return clearId.md5()
        }else{
            return user.encryptorId!
        }
    }
}

