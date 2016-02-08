//
//  UserServiceProtocol.swift
//  snag-a-message
//
//  Created by OL_vmox on 2/8/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    
    func loadAllFriends(user: SnagUser) -> SnagUser
    func loadAllMessages(user: SnagUser) -> SnagUser
    func loadAllconversation(user: SnagUser) -> SnagUser
}