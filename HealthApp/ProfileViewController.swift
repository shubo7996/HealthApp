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

class ProfileViewController: UITableViewController {

    @IBOutlet weak var ProfilePicview: UIImageView!
    
    var ControlsArray : [String] = []
    //let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
    super.viewDidLoad()
        loggedinuser()
        
        //ControlsArray = ["Edit Profile", "Settings", "Terms and Conditions"]
        //tableView.dataSource = self as! UITableViewDataSource
        //tableView.delegate = self as! UITableViewDelegate
        
        ControlsArray.append("Edit Profile")
        ControlsArray.append("Settings")
        ControlsArray.append("Terms and Condition")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ControlsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
        let CA = ControlsArray[indexPath.row]
        cell.textLabel?.text = CA
        }
        return cell
    }
        

    @IBAction func SignOut(_ sender: Any) {
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
