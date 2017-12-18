//
//  SignUpTableViewController.swift
//  
//
//  Created by Subhamoy Paul on 9/30/17.
//
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftKeychainWrapper

var ref: DatabaseReference?

class SignUpTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: key_uid){
            performSegue(withIdentifier: "signup", sender: nil)
        }
    }
    
    

    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    @IBAction func ChangeProfilePicture(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //after completion
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            ImageView.image = image
        }
        else
        {
            print ("Error")
        }
        
        self.dismiss(animated: true,completion: nil)
        
    }
    
    
    
    
    @IBOutlet weak var EmailTextfield: UITextField!
    
    
    @IBOutlet weak var FullNameTextField: UITextField!
    
    
    @IBOutlet weak var UserNameTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    @IBAction func SignUp(_ sender: Any) {
        
        if EmailTextfield.text != "" && FullNameTextField.text != "" && UserNameTextField.text != "" && PasswordTextField.text != ""
        {
            Auth.auth().createUser(withEmail: EmailTextfield.text!, password: PasswordTextField.text!, completion: { (user, error) in
                if user != nil && error == nil
                {
                    
                    
                    
                    guard let uid = user?.uid else {
                        return
                    }
                    let imageName = NSUUID().uuidString
                    let storageRef = Storage.storage().reference().child("\(imageName).png")
                    if let uploadData = UIImagePNGRepresentation(self.ImageView.image!){
                        
                        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            if error != nil{
                                print (error!)
                                return
                            }
                            if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                                
                                let values = ["name": self.FullNameTextField.text!, "email": self.EmailTextfield.text!, "username": self.UserNameTextField.text!, "profileImageURL": profileImageURL]
                                
                                self.StoringUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                                
                                }
                            
                        })
                        
                        }
                    
                    KeychainWrapper.standard.set((user?.uid)!, forKey: key_uid)
                    self.performSegue(withIdentifier: "signup", sender: nil)
                    
                    
                    
                    
                    
                    
                   /* UserDefaults.standard.set(user!.email, forKey: "usersigned")
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
    
    private func StoringUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]){
        
        ref = Database.database().reference()
        
        let userRef = ref?.child("User").child(uid)
        
        userRef?.updateChildValues(values)
    
    }
    
    


}
