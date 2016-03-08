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
    let kPassword = "password"
    let kRooms = "rooms"
    
    let username: String
    let email: String
    let password: String
    var roomIDs: [String] = []
    var rooms: [Room] = []
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    var jsonValue: [String: AnyObject] {
        return [kUsername: username, kEmail: email, kPassword: password, kRooms: roomIDs]
    }
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
        let email = json[kEmail] as? String,
            let password = json[kPassword] as? String else { return nil }
        self.username = username
        self.email = email
        self.password = password
        self.identifier = identifier
    }
}