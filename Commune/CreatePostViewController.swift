//
//  AddPostViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var postTextView: UITextView!
    
    var room: Room?
    var post: Post?
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Current room is \(room)")
        
        RoomTableViewController.sharedInstance.room = room
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        text = postTextView.text
        PostController.createPost(text!, sender: UserController.currentUser, room: room!) { (post) -> Void in
            if post != nil {
                print("Post successfully created")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print("Failed to save post")
            }
        }
    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

