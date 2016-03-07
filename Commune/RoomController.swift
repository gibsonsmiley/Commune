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
        FirebaseController.base.
    }
}