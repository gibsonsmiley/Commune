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
    @IBOutlet weak var toolbar: UIToolbar!
    
    var room: String?
    var users: [User] = [] //String?

    override func viewDidLoad() {
        super.viewDidLoad()

        roomMemberTextField.inputView = memberPicker
        
        self.memberPicker.dataSource = self
        self.memberPicker.delegate = self
        
        toolbar.sizeToFit()
        roomMemberTextField.inputAccessoryView = toolbar
    }

//    MARK: - PickerView Methods
    
//    Number of columns in the picker - I just need one
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

//    Number of rows in the picker - this is based off of how many users exist
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
//    The name of each row - this will be the users' usernames
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.users[row].username
    }
    
//    Capture the data each row represents - this may go into the toolbarAddButton action. Otherwise this method should be calling on the above method for data
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
//    MARK: - Action Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        room = roomNameTextField.text
//        users = roomMemberTextField.text
        roomNameTextField.resignFirstResponder()
        roomMemberTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func createButtonTapped(sender: AnyObject) {
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

    @IBAction func toolbarAddButtonTapped(sender: AnyObject) {
//        whatever the picker is currently presenting is added to the member text field
        let index = self.memberPicker.selectedRowInComponent(0)
        let username = self.users[index]
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
