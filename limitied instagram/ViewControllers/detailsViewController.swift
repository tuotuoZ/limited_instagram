//
//  detailsViewController.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/17/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import Parse

class detailsViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        post?.media.getDataInBackground{ (imageData: Data?, error: Error?) in
            if (error == nil) {
                
                let image = UIImage(data: imageData!)
                self.detailImage.image = image
                
            }
        }
        captionLabel.text = post?.caption
       
        timeLabel.text = post!.date

        
        
        // Do any additional setup after loading the view.
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
