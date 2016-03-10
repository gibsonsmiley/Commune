//
//  PostTableViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var rooms: [Room] = []

    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    override func viewWillAppear(animated: Bool) {
        if let currentUser = UserController.currentUser {
            print("\(currentUser.identifier) is signed in")
        } else {
           performSegueWithIdentifier("authModalSegue", sender: self)
        }
    }
    
    func loadRoomsForUser(user: User) {
        UserController.observeRoomsForUserID(user) { (rooms) -> Void in
            if let rooms = rooms {
                self.rooms = rooms
                self.tableView.reloadData()
            } else {
                self.createAlert("Something went wrong while trying to load all your rooms! Please try again.", success: false)
            }
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
        
        cell.textLabel?.text = rooms.name
        cell.detailTextLabel?.text = String(rooms.users)
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRoomView" {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let room = rooms[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? RoomTableViewController
                destinationViewController?.room = room
            }
        }
    }

}
