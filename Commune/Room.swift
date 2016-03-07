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
    let kMembers = "member"
    let kPosts = "posts"
    
    let name: String
    let members: [User]?
    let posts: [Post]?
    var identifier: String?
    var endpoint: String {
        return "rooms"
    }
    var jsonValue: [String: AnyObject] {
        return [kName: name]
    }
    
    init(name: String, members: [User]?, posts: [Post]?) {
        self.name = name
        self.members = []
        self.posts = []
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let name = json[kName] as? String,
        let members = json[kMembers] as? [User]?,
        let posts = json[kPosts] as? [Post]? else { return nil }
        self.name = name
        self.members = []
        self.posts = []
    }
}