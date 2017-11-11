//
//  SignInTableViewController.swift
//  HealthApp
//
//  Created by Subhamoy Paul on 9/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInTableViewController: UITableViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    @IBAction func SignIn(_ sender: Any) {
        if EmailTextField.text != "" && PasswordTextField.text != ""
        {
            Auth.auth().signIn(withEmail: EmailTextField.text!, password: PasswordTextField.text!, completion: { (user, error) in
                
                if user != nil && error == nil
                {
                    UserDefaults.standard.set(user!.email, forKey: "usersigned")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                    
                }
                else
                {
                    print ("error")
                }
        })
    }

    }

}
