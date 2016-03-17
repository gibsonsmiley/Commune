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
    @IBOutlet var memberPicker: UIPickerView!
    @IBOutlet var toolbar: UIToolbar!
    
    var room: Room?
    var name: String?
    var users: [User] = []
    var recipients: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        roomMemberTextField.inputView = memberPicker
        toolbar.sizeToFit()
        roomMemberTextField.inputAccessoryView = toolbar
               
        UserController.fetchAllUsers { (users) -> Void in
            if let users = users {
                self.users = users
            } else {
                self.users = []
            }
        }
    }
    
//    MARK: - PickerView Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.users[row].username
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    
//    MARK: - Action Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        roomNameTextField.resignFirstResponder()
        roomMemberTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        name = roomNameTextField.text!
        self.view.window?.endEditing(true)
            RoomController.createRoom(recipients, name: roomNameTextField.text!, completion: { (room) -> Void in
                if room != nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    print("Failed to create room")
                }
            })
//        HomeTableViewController.performSegueWithIdentifier("toRoomView", sender: HomeTableViewController())
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func toolbarAddButtonTapped(sender: AnyObject) {
        let index = self.memberPicker.selectedRowInComponent(0)
        let users = self.users[index]
        self.recipients.append(users)
        
        var participantsText = ""
        for recipient in recipients {
            participantsText += recipient.username + ", "
        }
        roomMemberTextField.text = participantsText
    }

    @IBAction func toolbarDoneButtonTapped(sender: AnyObject) {
        roomMemberTextField.resignFirstResponder()
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
