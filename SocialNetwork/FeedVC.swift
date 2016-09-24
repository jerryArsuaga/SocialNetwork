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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageBtn: UIImageView!
    
    
    @IBOutlet weak var captionField: UITextField!
    
    
    var posts = [Post]()
    var imagePicker:UIImagePickerController!
    static var imageCache: NSCache<NSString,UIImage> = NSCache()
    var imageSelected:Bool = false
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
        
            addImageBtn.image = image
            imageSelected = true
            
        }else
        {
            print("Jerry: A invalid image was selected")
            
        }
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
    
  
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.allowsEditing = true
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.imagePicker.delegate = self;
        self.captionField.delegate = self;
        
        //VAmos a generar un listener por si algo cambia que se actualice 
        DataService.ds.REF_POSTS.observe(.value,with: { (snapshot) in
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                if self.posts.count != 0 {
                
                    self.posts = []
                }
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
    
    
    @IBAction func postButtonTapped(_ sender: AnyObject) {
        
        //Es como un tipo de try y catch para validar cosas
        captionField.endEditing(true)
        guard let caption = captionField.text, caption != "" else{
        
            print("Jerry: Caption must be entered")
            return
            
        }
        
        guard let img = addImageBtn.image, self.imageSelected == true else
        {
            print("Jerry: An image must be selected")
            return
        }
        
        
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2)
        {
            let imgUID = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            DataService.ds.REF_POST_PICS.child(imgUID).put(imgData, metadata: metadata, completion: { (metadata, error) in
                if error != nil
                {
                    print("Jerry: No se pudo subir la imagen al servidor")
                }else
                {
                    print("Jerry: Si se pudo subir la imagen al servidor")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    
                    if let url = downloadURL{
                        self.postToFireBase(imageUrl: url)
                        self.captionField.text = ""
                        self.imageSelected  = false
                        self.addImageBtn.image = UIImage(named: "add-image")
                    }
                    
                    
                   
                    
                    
                }
                
                
            })
        }
        
        
    }
    
    
    
    func postToFireBase(imageUrl:String){
    
        let post:Dictionary<String,AnyObject> =
            [
                "caption" : captionField.text! as AnyObject,
                "imageUrl" : imageUrl as AnyObject,
                "likes" : 0 as AnyObject
            ]
        
        
        
        
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        
        firebasePost.setValue(post)
        
    
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
