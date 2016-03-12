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
    let kUser = "users"
    
    let username: String
    let email: String
    var roomIDs: [String] = [] {
        didSet {
            if self.identifier == UserController.currentUser.identifier {
                self.saveUserToDefaults()
            }
        }
    }
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
        self.identifier = identifier
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String,
            let email = json[kEmail] as? String,
        let roomDictionary = json[kRooms] as? [String: AnyObject] else { return nil }
        let rooms = Array(roomDictionary.keys)
        self.username = username
        self.email = email
        self.identifier = identifier
        self.roomIDs = rooms
    }
    
    func saveUserToDefaults() {
        NSUserDefaults.standardUserDefaults().setValue(self.jsonValue, forKey: kUser)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}