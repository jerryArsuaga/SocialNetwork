//
//  SignInVC.swift
//  SocialNetwork
//
//  Created by José Ramón Arsuaga Sotres on 08/09/16.
//  Copyright © 2016 Whappif. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        passwordField.delegate = self;
        emailField.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = KeychainWrapper.defaultKeychainWrapper.stringForKey(keyUID)
        {
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
    }
    
    
    @IBAction func fbButtonTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil
            {
                print("Jerry: Unable to authenticate with facebook")
                
            }else if result?.isCancelled == true{
                
                print("Jerry: User cancellede authentication")
                
                
            }else
            {
                print("Jerry: Succesfully authenticated")
                
                
                //Generamos las credenciales para fire base
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.fireBaseAuthenticate(credential)
                
            }
        }
        
    }
    
    func fireBaseAuthenticate(_ credential: FIRAuthCredential)
    {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil
            {
                print("Jerry: Unable to authenticate with fireBase")
                
                
            }else
            {
                print("Jerry: Succesfully authenticated with fireBase")
                
                if let user = user
                {
                    self.completeSignIn(id: user.uid);
                    
                    
                }
                
                
            }
        })
    }
    
    
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        
        
        guard let email = emailField.text, !email.isEmpty else{
            
            print("The email field needs to be populated")
            return
            
        }
        
        guard let pwd = passwordField.text , !pwd.isEmpty else{
            
            print("The password field needs to be populated")
            return
            
        }
        
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error == nil
            {
                print("Jerry: Able to authenticate with fireBase by mail")
                if let user = user{
                    
                    self.completeSignIn(id: user.uid)
                }
            }else
            {
                print("Jerry: Unable to authenticate with fireBase by mail")
                
                FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                    if(error != nil)
                    {
                        print("Jerry: Unable to save user")
                    }else
                    {
                        if let user = user{
                        
                            self.completeSignIn(id: user.uid)
                        }
                    }
                })
                
            }
        })
    }
    
    func completeSignIn(id: String)
    {
     let keyChainResult = KeychainWrapper.defaultKeychainWrapper.setString(id, forKey: keyUID)
        
        performSegue(withIdentifier: "FeedVC", sender: nil)
        
        print("Jerry: Datos guardados correctamente \(keyChainResult)");
    }
    
    
    
    
    
    
}

