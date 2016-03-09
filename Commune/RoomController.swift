//
//  RoomController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class RoomController {
    
    static func observePostsForRoomID(roomID: String, completion: (posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("room").queryEqualToValue(roomID).observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                let orderedPosts = PostController.orderPosts(posts)
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
        })
    }
    
    static func createRoom(users: [User], name: String, completion: (room: Room?) -> Void) {
        var room = Room(name: name, users: users)
        room.save()
        if let identifier = room.identifier {
            for var user in users {
                user.roomIDs.append(identifier)
                user.save()
            }
        }
    }

    static func deleteRoom(room: Room) {
        room.delete()
    }
    
    static func fetchRoomForID(roomID: String, completion: (room: Room?) -> Void) {
        FirebaseController.dataAtEndpoint("rooms/\(roomID)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let room = Room(json: data, identifier: roomID)
                completion(room: room)
            } else {
                completion(room: nil)
            }
        }
    }
    
    static func fetchUsersForRoomID(room: Room, completion: (users: [User]?) -> Void) {
        guard let identifier = room.identifier else {completion(users: nil); return}
        FirebaseController.base.childByAppendingPath("users").queryOrderedByChild("rooms").queryEqualToValue(identifier).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let userDictionaries = snapshot.value as? [String: AnyObject] {
                let users = userDictionaries.flatMap({User(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                completion(users: users)
            } else {
                completion(users: nil)
            }
        })
    }
    
    static func orderRooms(rooms: [Room]) -> [Room] {
        return rooms.sort({$0.0.identifier > $0.1.identifier})
    }
    
//    static func leaveRoom() {}
    
//    static func joinRoom() {}
}