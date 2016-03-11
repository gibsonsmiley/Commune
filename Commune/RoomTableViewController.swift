//
//  PostDetailTableViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController {
    
    var room: Room?
    var posts: [Post] {
        return RoomController.posts
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPostsForRoom(room!)
    }
    
    func loadPostsForRoom(room: Room) {
        RoomController.observePostsForRoomID(room) { () -> Void in
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)
        let posts = self.posts[indexPath.row]

        cell.textLabel?.text = posts.text
        cell.detailTextLabel?.text = posts.sender?.username
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
