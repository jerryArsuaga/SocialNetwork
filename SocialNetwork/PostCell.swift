//
//  PostCell.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 14/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var noLikesLabel: UILabel!
    @IBOutlet weak var postText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
