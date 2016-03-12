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
    
    var post: Post?
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func saveButtonTapped(sender: AnyObject) {
//        text = postTextView.text
//        PostController.createPost(text!, sender: UserController.currentUser, room: HomeTableViewController.rooms) { (post) -> Void in
//            if post != nil {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else {
//                print("Failed to save post")
//            }
//        }

    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

