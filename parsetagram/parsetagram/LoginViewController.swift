//
//  LoginViewController.swift
//  parsetagram
//
//  Created by Diana C on 3/9/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    static let userDidLoginNotification = NSNotification.Name("UserDidLogin")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Yay, created a user")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
//                if error?.code == 202 {
//                    print("account already exists for this username")
//                }
                print(error?.localizedDescription)
                if let error = error as! NSError? {
                    if (error.code == 202) {
                        print("account already exists for this username")
                    }
                }
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're logged in!")
                NotificationCenter.default.post(name: LoginViewController.userDidLoginNotification, object: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
