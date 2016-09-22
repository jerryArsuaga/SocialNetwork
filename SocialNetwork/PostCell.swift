//
//  PostCell.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 14/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit
import Firebase

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

    func configureCell(post:Post, img:UIImage?)
    {
        self.postText.text = post.caption
        self.post = post
        self.noLikesLabel.text = "\(post.likes)"
        
        if img != nil
        {
            self.postImage.image = img
        }else
        {
            
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil
                    {
                        print("Jerry: Existió un error al obtener la imagen de storage")
                    }else
                    {
                        print("Jerry: Se descargo la imagen correctamente")
                        if let imgData = data
                        {
                            if let img = UIImage(data: imgData)
                            {
                                self.postImage.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                                                                       
                    }
                })
            
        }
        
        
        
        
        
        
    }

}
