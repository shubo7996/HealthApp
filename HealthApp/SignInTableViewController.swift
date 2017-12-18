//
//  SignInTableViewController.swift
//  HealthApp
//
//  Created by Subhamoy Paul on 9/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class SignInTableViewController: UITableViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: key_uid){
            performSegue(withIdentifier: "login", sender: nil)
        }
    }
    
    
    @IBAction func SignIn(_ sender: Any) {
        if EmailTextField.text != "" && PasswordTextField.text != ""
        {
            Auth.auth().signIn(withEmail: EmailTextField.text!, password: PasswordTextField.text!, completion: { (user, error) in
                
                if user != nil && error == nil
                {
                    let keychainResult = KeychainWrapper.standard.set((user?.uid)!, forKey: key_uid)
                    print(keychainResult)
                    self.performSegue(withIdentifier: "login", sender: nil)
                   /*
                    UserDefaults.standard.set(user!.email, forKey: "usersigned")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
 */
                    
                }
                else
                {
                    print ("error")
                }
        })
    }

    }

}
