//
//  AuthPageViewController.swift
//  Commune
//
//  Created by Gibson Smiley on 3/7/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class AuthPageViewController: UIViewController {
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var signupUsernameTextField: UITextField!
    @IBOutlet weak var signupEmailTextField: UITextField!
    @IBOutlet weak var signupPasswordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        if loginEmailTextField.text?.isEmpty == true || loginPasswordTextField.text?.isEmpty == true {
            self.createAlert("Both an email and a password are required to sign in. Please try again.", success: false)
        } else {
            UserController.authenticateUser(loginEmailTextField.text!, password: loginPasswordTextField.text!) { (success, user) -> Void in
                if success, let _ = user {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.createAlert("There was an error logging in! Please try again.", success: false)
                }
            }
        }
    }
    
    @IBAction func signupButtonTapped(sender: AnyObject) {
        if signupEmailTextField.text?.isEmpty == true || signupPasswordTextField.text?.isEmpty == true || signupUsernameTextField.text?.isEmpty == true {
            self.createAlert("You need to provide an email, password, and a username to sign up. Please try again.", success: false)
        } else {
            if signupEmailTextField.text?.containsString("@") == false {
                self.createAlert("Please provide a correct email address. 'Example@example.com", success: false)
            } else {
                UserController.createUser(signupEmailTextField.text!, username: signupUsernameTextField.text!, password: signupPasswordTextField.text!) { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.createAlert("There was an error signing up! Please try again.", success: false)
                    }
                }
            }
        }
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loginEmailTextField.resignFirstResponder()
        loginPasswordTextField.resignFirstResponder()
        signupEmailTextField.resignFirstResponder()
        signupPasswordTextField.resignFirstResponder()
        signupUsernameTextField.resignFirstResponder()
        return true
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
