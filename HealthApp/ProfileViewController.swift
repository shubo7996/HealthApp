//
//  ProfileViewController.swift
//  HealthApp
//
//  Created by Subhamoy Paul on 12/16/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class ProfileViewController: UITableViewController {

    @IBOutlet weak var ProfilePicview: UIImageView!
    
    
    var ControlsArray : [String] = []
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        loggedinuser()
        
        //ControlsArray = ["Edit Profile", "Settings", "Terms and Conditions"]
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: key_uid){
            performSegue(withIdentifier: "goToLogin", sender: nil)
        }
    } */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return ControlsArray.count
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //let CA = ControlsArray[indexPath.row]
        cell.textLabel?.text = "why you no working?"
        return cell
    }
        

 /*   @IBAction func SignOut(_ sender: Any) {
      
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: key_uid)
        
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToLogin", sender: self)
        
        /*
        UserDefaults.standard.removeObject(forKey: "usersigned")
        UserDefaults.standard.synchronize()
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC")
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signUp
        
        delegate.rememberLogin()
 */
    }
    */
    
    @IBAction func logout(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: key_uid)
        
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToLogin", sender: nil)
    }
    

    func loggedinuser() {
        if Auth.auth().currentUser?.uid != nil
        {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("User").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if !snapshot.exists() { return }
                let dictionary = snapshot.value as! NSDictionary
                let downloadURL = (dictionary["profileImageURL"] as! String)
                self.loadingImageFromDatabase(downloadURL: downloadURL)
                
            })
            
            
        }
    }
    
    func loadingImageFromDatabase(downloadURL: String) {
        let storageRef = Storage.storage().reference(forURL: downloadURL)
        storageRef.downloadURL { (url, error) in
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) { self.ProfilePicview.image = image }
            }
        }
    }
            
    
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
