//
//  HomeViewController.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        let query = PFQuery(className: "Post")
        query.limit = 20
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = Post.postsFromArray(objects: posts)
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell") as! PostViewCell
        
        let post = (posts?[indexPath.row])!
        
        post.image?.getDataInBackground({ (imageData: Data?, error: Error?) in
            if error != nil {
                if let imageData = imageData {
                    cell.instaImageView.image = UIImage(data: imageData)
                }
            } else {
                print(error?.localizedDescription)
            }
        }, progressBlock: nil)
        
        if post.caption != nil {
            cell.captionLabel.text = post.caption!
        } else {
            cell.captionLabel.text = ""
        }
        
        if post.author != nil {
            cell.authorLabel.text = post.author?.username!
        } else {
            cell.authorLabel.text = ""
        }
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
