//
//  feedCell.swift
//  limitied instagram
//
//  Created by Tony Zhang on 10/16/18.
//  Copyright © 2018 Tony. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postPhotos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
