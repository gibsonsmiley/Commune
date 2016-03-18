//
//  PostDetailTableViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController {
    
    static let sharedInstance = RoomTableViewController()
    
    var room: Room!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPostsForRoom(room)
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func loadPostsForRoom(room: Room) {
        RoomController.observePostsForRoomID(room) { () -> Void in
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomController.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)
        let posts = RoomController.posts[indexPath.row]
        cell.textLabel?.text = posts.text
        cell.detailTextLabel?.text = posts.sender?.username
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toCreatePost" {
            let destinationViewController = segue.destinationViewController as? CreatePostViewController
            let room = self.room
            destinationViewController?.room = room
        }
    }
}
