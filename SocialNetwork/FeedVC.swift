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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //VAmos a generar un listener por si algo cambia que se actualice 
        DataService.ds.REF_POSTS.observe(.value,with: { (snapshot) in
            print("Jerry: \(snapshot.value)")
        })

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        {
            return cell
        }else
        {
            return UITableViewCell()
        }
        
    }
    
    
    
    

  
    @IBAction func signOutTapped(_ sender: AnyObject) {
        
        _ = KeychainWrapper.defaultKeychainWrapper.removeObjectForKey(keyUID)
        
        try! FIRAuth.auth()?.signOut()
        
        
        dismiss(animated: true, completion: nil);
    }

}
