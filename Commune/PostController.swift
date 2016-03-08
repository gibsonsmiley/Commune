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
    
    static func fetchPostsForUser(user: User, completion: (post: [Post]?) -> Void) {
        
    }
    
    
    //////// Have to figure out a way to specify when creating a post whether it goes
    
    static func createPost(name: String, recipient: String, text: String) {
        var post = Post(sender: "\(UserController.currentUser)", name: name, receiver: recipient, text: text)
        post.save()
        
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                let orderedPosts = orderPosts(posts)
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
        })
    }
    
    static func deletePost(post: Post) {
        post.delete()
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return posts.sort({$0.0.identifier > $0.1.identifier})
    }
}