//
//  CreateRoomViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/8/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController {
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomMemberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("toRoomView", sender: HomeTableViewController())
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
