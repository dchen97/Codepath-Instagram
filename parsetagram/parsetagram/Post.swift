//
//  Post.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    var image: PFFile?
    let author: PFUser?
    let caption: String?
    let commentsCount: Int?
    let likesCount: Int?
    
    init(object: PFObject) {
        self.image = object["media"] as! PFFile
        self.author = object["author"] as? PFUser
        self.caption = object["caption"] as? String
        self.commentsCount = object["commentsCount"] as? Int
        self.likesCount = object["likesCount"] as? Int
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: @escaping PFBooleanResultBlock) {
        let post = PFObject(className: "Post")
        
        post["media"] = getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        
        return nil
    }
    
    class func postsFromArray(objects: [PFObject]?) -> [Post]? {
        var posts = [Post]()
        
        if let objects = objects {
            for object in objects {
                let post = Post(object: object)
                
                posts.append(post)
            }
            return posts
        }
        return nil
        
    }

}
