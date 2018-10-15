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
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil{
                print("you logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = usernameField.text
        
        
    
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success{
                print("Yay, created a user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
