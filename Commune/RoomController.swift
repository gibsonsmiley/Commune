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
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("room").queryEqualToValue("\(identifier)").observeEventType(.Value, withBlock: { (snapshot) -> Void in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                self.posts = posts
                completion()
            }
        })
    }
    
    static func createRoom(users: [User], name: String, completion: (room: Room?) -> Void) {
        var room = Room(name: name, users: users)
        room.users.append(UserController.currentUser)
        room.userIDs.append(UserController.currentUser.identifier!)
        room.save()
        if let identifier = room.identifier {
            for var user in room.users {
                user.roomIDs.append(identifier)
                user.save()
                print("room created successfully")
            }
        }
        completion(room: room)
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