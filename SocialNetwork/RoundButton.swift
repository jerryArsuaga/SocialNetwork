//
//  RoundButton.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 08/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //El color de la sombra
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor;
        
        //Que tan opaca va a ser la sombra
        layer.shadowOpacity = 0.8
        
        //Que tanto se desvanece hacía afuera
        layer.shadowRadius = 5.0
        
        //De las orillas hacía donde se sale
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        //La imagen dentro del botón se va a escalar de forma correcta
        imageView?.contentMode = .scaleAspectFit;
        
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        layer.cornerRadius = self.frame.width / 2
        
        
    }

}
