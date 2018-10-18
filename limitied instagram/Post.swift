//
//  posts.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/16/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit
import Parse

public class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    @NSManaged var date: String

    
    /* Needed to implement PFSubclassing interface */
    public class func parseClassName() -> String {
        return "Post"
    }
    
    
    
}


