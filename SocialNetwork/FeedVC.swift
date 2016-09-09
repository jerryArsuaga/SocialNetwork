//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 08/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
    @IBAction func signOutTapped(_ sender: AnyObject) {
        
        let keyhcainResulto  = KeychainWrapper.defaultKeychainWrapper.removeObjectForKey(keyUID)
        
        try! FIRAuth.auth()?.signOut()
        
        
        dismiss(animated: true, completion: nil);
    }

}
