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


class SignInVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self;
        emailField.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                }else
                {
                    print("Jerry: Unable to authenticate with fireBase by mail")
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if(error != nil)
                        {
                            print("Jerry: Unable to save user")
                        }else
                        {
                            print("Jerry: User saved");
                        }
                    })
                    
                }
            })
        }
        
    
    
    
}

