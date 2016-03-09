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
    
//    static func fetchPostsForUser(user: User, completion: (post: [Post]?) -> Void) {
//        //Is this necessary?
//    }
    
    static func createPost(text: String, sender: User, room: Room, completion: (post: Post?) -> Void) {
        guard let senderID = sender.identifier, roomID = room.identifier else { completion(post: nil); return }
        var post = Post(senderID: senderID, roomID: roomID, text: text)
        post.save()
        completion(post: post)
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