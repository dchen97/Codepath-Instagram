//
//  User.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    let username: String?
    
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = NSNotification.Name("UserDidLogout")
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        self.username = dictionary["username"] as? String
    }
    
//    static var _currentUser: User?
//    
//    class var currentUser: User? {
//        get {
//            if _currentUser == nil {
//                let defaults = UserDefaults.standard
//                
//                let userData = defaults.object(forKey: "currentUserData") as? NSData
//                
//                if let userData = userData {
//                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [.allowFragments]) as! NSDictionary
//                    
//                    _currentUser = User(dictionary: dictionary)
//                }
//            }
//            
//            return _currentUser
//        }
//        
//        set(user) {
//            _currentUser = user
//            
//            let defaults = UserDefaults.standard
//            
//            if let user = user {
//                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
//                defaults.set(data, forKey: "currentUserData")
//            } else {
//                defaults.removeObject(forKey: "currentUserData")
//            }
//            
//            //defaults.set(user, forKey: "currentUser")
//            
//            defaults.synchronize()
//        }
//    }
}
