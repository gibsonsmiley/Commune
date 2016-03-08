//
//  PostController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class PostController {
    static let sharedInstance = PostController()
    var posts: [Post] = []
    
    static func observePostForIdentifier(identifier: String, completion: (post: Post) -> Void) {
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let postDictionary = data as? [String: AnyObject] {
                var posts: [Post] = []
                if let post = Post(json: postDictionary, identifier: identifier) {
                    posts.append(post)
                }
            }
        }
    }
    
    static func createPost(name: String, recipient: String, text: String) {
        var post = Post(sender: "\(UserController.currentUser)", name: name, receiver: recipient, text: text)
    }
}