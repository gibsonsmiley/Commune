//
//  PostTableViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var rooms: [Room] {
        return UserController.currentUserRooms
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
//        UserController.createUser("email@email.com", username: "TestUser1", password: "1234") { (success, user) -> Void in
//            if let firstUser = user {
//                UserController.createUser("emailed@emailed.com", username: "TestUser2", password: "1234", completion: { (success, user) -> Void in
//                    if let secondUser = user {
//                        RoomController.createRoom([firstUser, secondUser], name: "TestRoom", completion: { (room) -> Void in
//                            if let room = room {
//                                PostController.createPost("Test post, please ignore", sender: firstUser, room: room, completion: { (post) -> Void in
//                                    if let post = post {
//                                        print(post)
//                                    }
//                                })
//                            }
//                        })
//                    }
//                })
//            }
//        }
        if UserController.currentUser != nil {
        loadRoomsForUser(UserController.currentUser)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        if UserController.currentUser == nil {
           performSegueWithIdentifier("authModalSegue", sender: self)
        }
    }
    
    func loadRoomsForUser(user: User) {
        UserController.observeRoomsForUserID(user) { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    func loadUsersForRoom(room: Room) {
        RoomController.fetchUsersForRoomID(room) { (users) -> Void in
            self.tableView.reloadData()
        }
    }

    @IBAction func addRoomButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        UserController.logoutUser()
        performSegueWithIdentifier("authModalSegue", sender: self)
    }
    
    func createAlert(message: String, success: Bool) {
        var titleString = ""
        if success == false {
            titleString = "Uh oh!"
        }
        let alertController = UIAlertController(title: titleString, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("roomCell", forIndexPath: indexPath)
        let rooms = self.rooms[indexPath.row]
                
        let roomMemberArray = rooms.users
        var roomMembers = ""
        for users in roomMemberArray {
            roomMembers += users.username + ", "
    }
        cell.textLabel?.text = rooms.name
        cell.detailTextLabel?.text = roomMembers
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRoomView" {

            let destinationViewController = segue.destinationViewController as? RoomTableViewController
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let room = UserController.currentUserRooms[indexPath.row]
                destinationViewController?.room = room
            } else if let createViewController = sender as? CreateRoomViewController {
                if let room = createViewController.room {
                    destinationViewController?.room = room
                }
            }
        }
    }

}
