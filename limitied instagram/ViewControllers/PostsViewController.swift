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
    var posts: [Post] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        reloadPost()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        reloadPost()
        print(posts.count)

    }

    @objc func reloadPost() {
       
        
        // construct query
        let query = Post.query()
        query?.includeKey("media")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                
            }
            else{
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        if posts.count == 0 {
            print("nothing")
        }else{
            let post = self.posts[indexPath.row] as! Post
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let cell = sender as! feedCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! detailsViewController
                detailViewController.post = post
            }
        }
    }

}


