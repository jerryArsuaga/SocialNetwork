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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageBtn: UIImageView!
    
    
    var posts = [Post]()
    var imagePicker:UIImagePickerController!
    static var imageCache: NSCache<NSString,UIImage> = NSCache()
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
        
            addImageBtn.image = image
            
        }else
        {
            print("Jerry: A invalid image was selected")
        }
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.allowsEditing = true
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.imagePicker.delegate = self;
        
        //VAmos a generar un listener por si algo cambia que se actualice 
        DataService.ds.REF_POSTS.observe(.value,with: { (snapshot) in
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    if let postDic = snap.value as? Dictionary<String,AnyObject>
                    {
                        let key  = snap.key
                        let post = Post(postKey: key, postData: postDic)
                        self.posts.append(post)
                    }
                    
                }
                
                self.tableView.reloadData()
                
            }
            
            
            
        })

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        {
           let post = posts[indexPath.row]
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString)
            {
                cell.configureCell(post: post, img: img)
            }else{
            
                cell.configureCell(post: post, img:nil)
                
            }
            
            return cell
        }else
        {
            return PostCell()
        }
        
    }
    
    
    
    
    @IBAction func imagePickerTapped(_ sender: AnyObject) {
        
        present(self.imagePicker, animated: true, completion: nil)
        
    }

  
    @IBAction func signOutTapped(_ sender: AnyObject) {
        
        _ = KeychainWrapper.defaultKeychainWrapper.removeObjectForKey(keyUID)
        
        try! FIRAuth.auth()?.signOut()
        
        
        dismiss(animated: true, completion: nil);
    }

}
