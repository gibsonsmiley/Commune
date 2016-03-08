//
//  RoomController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class RoomController {
    static let sharedInstance = RoomController()
    var posts: [Post] = []
    var members: [User] = []
    
    func observePostsForRoomIdentifier(roomIdentifier: String, completion: (posts: [Post]) -> Void) {
        FirebaseController.observeDataAtEndpoint("room") { (data) -> Void in
            if let roomIdentifierDictionary = data as? [String: AnyObject] {
                var posts: [Post] = []
                let tunnel = dispatch_group_create()
                for (posts, _) in roomIdentifierDictionary {
                    dispatch_group_enter(tunnel)
                    FirebaseController.dataAtEndpoint("room/posts/\(posts)", completion: { (data) -> Void in
                        if let postsDictionary = data as? [String: AnyObject] {
                            if let post = Post(json: postsDictionary, identifier: posts) {
                                posts.append(post) // This should work... check with James
                            }
                        }
                        dispatch_group_leave(tunnel)
                    })
                }
                dispatch_group_notify(tunnel, dispatch_get_main_queue(), { () -> Void in
                    self.posts = posts
                })
            }
        }
    }
    
    static func createRoom(members: [User], name: String, posts: [Post], completion: (room: Room?) -> Void) {
        var room = Room(name: name, members: members, posts: posts)
        room.save()
        if let identifier = room.identifier {
            for var member in members {
                member.identifier?.append(identifier)
                member.save()
            }
        }
    }

    static func deleteRoom(room: Room) {
        room.delete()
    }
    
    
}