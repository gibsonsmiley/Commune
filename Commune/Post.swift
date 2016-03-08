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
    let kReceiver = "receiver"
    let kText = "text"
    let kName = "name"
    
    let sender: String
    let name: String
    let receiver: String
    let text: String
    var identifier: String?
    var endpoint: String {
        return "posts"
    }
    var jsonValue: [String: AnyObject] {
        return [kSender: sender, kName: name, kReceiver: receiver, kText: text]
    }
    
    init(sender: String, name: String, receiver: String, text: String) {
        self.sender = sender
        self.name = name
        self.receiver = receiver
        self.text = text
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let sender = json[kSender] as? String,
            let name = json[kName] as? String,
        let receiver = json[kReceiver] as? String,
        let text = json[kText] as? String else { return nil }
        self.sender = sender
        self.name = name
        self.receiver = receiver
        self.text = text
        self.identifier = identifier
    }
}