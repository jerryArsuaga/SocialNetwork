//
//  DataService.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 20/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    
    static let ds = DataService()
    
    
    //Referencias a la base de datos
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    //Referencias a storage
    private var _REF_STORAGE = STORAGE_BASE
    private var _REF_POST_PICS = STORAGE_BASE.child("post-pics")
    
    
    //Getters para la base de datos
    var REF_BASE: FIRDatabaseReference{
            return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    
    //Getters para el storage de archivos
    var REF_STORAGE:FIRStorageReference{
    
            return _REF_STORAGE
    
    }
    
    var REF_POST_PICS:FIRStorageReference{
        
        return _REF_POST_PICS
        
    }
    
    var REF_CURRENT_USER:FIRDatabaseReference{
    
        let uid = KeychainWrapper.defaultKeychainWrapper.stringForKey(keyUID)
        
        let user = _REF_USERS.child(uid!)
        
        return user
    }
    
    
    
    
    
    func createFirebaseDBUser(uid:String, userData:Dictionary<String,String>){
    
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    func createFirebaseDBPost(postkey:String, postData:Dictionary<String,AnyObject>)
    {
        REF_POSTS.child(postkey).updateChildValues(postData)
    }
    
    
    
    

    

}
