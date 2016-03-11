//
//  RoomController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class RoomController {
    
    static var posts: [Post] = []
    
    static func observePostsForRoomID(room: Room, completion: () -> Void) {
        guard let identifier = room.identifier else { completion(); return }
        FirebaseController.base.childByAppendingPath("rooms/\(identifier)/posts").observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if let postIDs = snapshot.value as? [String] {
                let roomGroup = dispatch_group_create()
                for postID in postIDs {
                    dispatch_group_enter(roomGroup)
                    PostController.postFromIdentifier(postID, completion: { (post) -> Void in
                        if let post = post {
                            posts.append(post)
                        }
                        dispatch_group_leave(roomGroup)
                    })
                    dispatch_group_notify(roomGroup, dispatch_get_main_queue(), { () -> Void in
                        completion()
                    })
                }
            } else {
                completion()
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