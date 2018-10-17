//
//  PostsViewController.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/16/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import Parse
import AFNetworking


class PostsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.reloadPost), userInfo: nil, repeats: true)
    }
    
    @objc func reloadPost() {
       
        
        // construct query
        let query = Post.query()
        query?.includeKey("media")
        query?.includeKey("author")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                
            }
            else{
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        if posts.count == 0 {
            print("nothing")
        }else{
            let post = self.posts[0] as! Post
            let postMedia = post.media as PFFile
            postMedia.getDataInBackground{ (imageData: Data?, error: Error?) in
                if (error == nil) {
                    
                    let image = UIImage(data: imageData!)
                    cell.postPhotos.image = image
                    
                }
            }
            cell.postText.text = posts[indexPath.row]["caption"] as? String
            
        }
        return cell
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                self.performSegue(withIdentifier: "logOut", sender: nil)
                
            }
        })
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


