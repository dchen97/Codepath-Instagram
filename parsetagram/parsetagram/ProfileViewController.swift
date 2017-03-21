//
//  ProfileViewController.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    static let userDidLogoutNotification = NSNotification.Name("UserDidLogout")

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("User logged out")
            
            NotificationCenter.default.post(name: ProfileViewController.userDidLogoutNotification, object: nil)
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
