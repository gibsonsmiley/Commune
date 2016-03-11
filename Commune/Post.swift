//
//  Post.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

struct Post: FirebaseType {
    
    let kSender = "sender"
    let kRoom = "room"
    let kText = "text"
    
    let senderID: String
    var sender: User?
    let roomID: String
    var text: String
    var identifier: String?
    var endpoint: String {
        return "posts"
    }
    var jsonValue: [String: AnyObject] {
        return [kSender: senderID, kRoom: roomID, kText: text]
    }
    
    init(senderID: String, roomID: String, text: String) {
        self.senderID = senderID
        self.roomID = roomID
        self.text = text
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let senderID = json[kSender] as? String,
            let roomID = json[kRoom] as? String,
            let text = json[kText] as? String else { return nil }
        self.senderID = senderID
        self.roomID = roomID
        self.text = text
        self.identifier = identifier
    }
}