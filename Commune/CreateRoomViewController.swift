//
//  CreateRoomViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/8/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomMemberTextField: UITextField!
    
    var room: String?
    var users: [User] = [] //String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func roomMemberTextFieldBeganEditing(sender: AnyObject) {
        let userPicker = UIPickerView()
        userPicker.delegate = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0
    }
    

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        UserController.fetchAllUsers { (keys) -> Void in
            return keys.count
        }
        return 0
    }
    
    func convertMembersToUser(members: String) -> [User] {
//        Some magical beautiful function to convert a string into an array of users, using "," to seperate users
        let string = roomMemberTextField.text
        
        let array = string?.characters.split{$0 == " "}.map(String.init)
        
//        Need to assign the objects in the array to users by their username
        
        return self.users
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        room = roomNameTextField.text
//        users = roomMemberTextField.text
        roomNameTextField.resignFirstResponder()
        roomMemberTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.view.window?.endEditing(true)
        if let room = room {
            RoomController.createRoom(users, name: room, completion: { (room) -> Void in
                if room != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    let failedAlert = UIAlertController(title: "Failed!", message: "The room couldn't be created! Please try again.", preferredStyle: .Alert)
                    failedAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(failedAlert, animated: true, completion: nil)
                }
            })
        }
        
//        HomeTableViewController.performSegueWithIdentifier("toRoomView", sender: HomeTableViewController())
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
