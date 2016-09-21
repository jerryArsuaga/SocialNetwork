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
    
    var post:Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configureCell(post:Post)
    {
        self.postText.text = post.caption
        self.post = post
        self.noLikesLabel.text = "\(post.likes)"
        
        
    }

}
