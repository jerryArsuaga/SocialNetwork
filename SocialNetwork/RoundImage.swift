//
//  RoundImage.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 14/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit

class RoundImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        
        
    }
    
    

}
