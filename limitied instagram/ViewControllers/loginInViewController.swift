//
//  loginInViewController.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/14/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import Parse

class loginInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                let errorController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                errorController.addAction(OKAction)
                self.present(errorController, animated: true) { }
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }

    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if (usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true){
            let alertController = UIAlertController(title: "Incomplete info", message: "The username or password box is empty", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) { }
        }else{
            registerUser()
        }
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let errorController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                errorController.addAction(OKAction)
                self.present(errorController, animated: true) { }
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    

}
