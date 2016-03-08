//
//  Room.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

struct Room: FirebaseType {
    
    let kName = "name"
    let kUsers = "users"
    
    let name: String
    var userIDs: [String] = []
    var users: [User] = []
    var identifier: String?
    var endpoint: String {
        return "rooms"
    }
    var jsonValue: [String: AnyObject] {
        return [kName: name]
    }
    
    init(name: String, users: [User]) {
        self.name = name
        self.users = []
        var identifiers: [String] = []
        for user in users {
            if let identifier = user.identifier {
                identifier.append(identifier)
            }
        }
        self.userIDs = identifiers
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let name = json[kName] as? String else { return nil }
        self.name = name
    }
}