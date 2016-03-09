//
//  UserController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class UserController {
    static let sharedInstance = UserController()
    private static let kUser = "userKey"
    static var currentUser: User! {
        get {
            guard let uid = FirebaseController.base.authData?.uid, let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else { return nil }
            return User(json: userDictionary, identifier: uid)
        }
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static func fetchUserForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = User(json: data, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (keys: [String]) -> Void) {
        FirebaseController.observeDataAtEndpoint("users") { (data) -> Void in
            if let users = data as? [String: AnyObject] {
                let userKeys = Array(users.keys)
                completion(keys: userKeys)
            } else {
                completion(keys: [])
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        FirebaseController.base.authUser(email, password: password) { (error, authData) -> Void in
            if error != nil {
                print("Error authenticating user: \(error.localizedDescription)")
                completion(success: false, user: nil)
            } else {
                UserController.fetchUserForIdentifier(authData.uid, completion: { (user) -> Void in
                    if let user = user {
                        currentUser = user
                    }
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func createUser(email: String, username: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        FirebaseController.base.createUser(email, password: password) { (error, results) -> Void in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(success: false, user: nil)
            } else {
                if let uid = results["uid"] as? String {
                    var user = User(username: username, email: email, identifier: uid)
                    user.save()
                }
            }
        }
    }
    
    static func logoutUser() {
        FirebaseController.base.unauth()
        UserController.currentUser = nil
    }
    
    static func observeRoomsForUserID(user: User, completion: (rooms: [Room]?) -> Void) {
        guard let identifier = user.identifier else { completion(rooms: nil); return }
        FirebaseController.base.childByAppendingPath("rooms").queryEqualToValue("user").queryEqualToValue(identifier).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let roomDictionaries = snapshot.value as? [String: AnyObject] {
                let rooms = roomDictionaries.flatMap({Room(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                completion(rooms: rooms)
            } else {
                completion(rooms: nil)
            }
        })
    }
} // END