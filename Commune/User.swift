//
//  User.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

struct User: FirebaseType {
    
    let kUsername = "username"
    let kEmail = "email"
    let kRooms = "rooms"
    
    let username: String
    let email: String
    var roomIDs: [String] = []
    var rooms: [Room] = []
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    var jsonValue: [String: AnyObject] {
        return [kUsername: username, kEmail: email, kRooms: roomIDs]
    }
    
    init(username: String, email: String, identifier: String? = nil) {
        self.username = username
        self.email = email
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
            let email = json[kEmail]as? String,
            roomIDs = json[kRooms] as? [String] else { return nil }
        self.username = username
        self.email = email
        self.roomIDs = roomIDs
        self.identifier = identifier
    }
}