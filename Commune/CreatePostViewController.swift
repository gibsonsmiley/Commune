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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        //save and post dat shit
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

