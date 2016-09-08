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


class SignInVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

