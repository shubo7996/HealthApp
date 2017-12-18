
//
//  TempViewController.swift
//  
//
//  Created by Subhamoy Paul on 10/3/17.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

var handle:DatabaseHandle?

var heightSelected: Double = 0.0
var weightSelected: Int = 0


var i = 0
class TempViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var heightPickerView: UIPickerView!
    @IBOutlet weak var weightPickerView: UIPickerView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var HeightArr: [Double] = []
    var WeightArr: [Int] = []
    
    
    func initialize(){
    for i in stride(from: 1, to: 8, by: 0.1) {
    HeightArr.append(i)
    }
        
    for i in stride(from: 1, to: 150, by: 1){
    WeightArr.append(i)
    }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        initialize()
        if heightPickerView == pickerView {
            return Int(HeightArr.count)
        } else if weightPickerView == pickerView {
            return WeightArr.count
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        initialize()
        if heightPickerView == pickerView {
            return String(HeightArr[row])
        } else if weightPickerView == pickerView{
            return String(WeightArr[row])
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if heightPickerView == pickerView {
            self.heightPickerView .selectedRow(inComponent: 0)
            heightSelected = Double(HeightArr[row])
            heightLabel.text = String(heightSelected)
        }
        else if weightPickerView == pickerView {
            self.weightPickerView.selectedRow(inComponent: 0)
            weightSelected = Int(WeightArr[row])
            weightLabel.text = String(weightSelected)
        }
        
        i = Int(add(weightSelected: weightSelected, heightSelected: Double(heightSelected) ))
        print (i)
        
    }
    func add (weightSelected: Int, heightSelected: Double) -> Double {
        
        let calculate = Double(weightSelected) / ((heightSelected * 0.3048) * (heightSelected * 0.3048))
        
        let values = ["Weight": weightSelected, "Height": heightSelected, "BMI": calculate] as [String : Any]
        Database.database().reference().child("User").child((Auth.auth().currentUser?.uid)!).updateChildValues(values)
        
        return calculate
        
        
    }
    
    
    
    
    
    @IBAction func save(_ sender: Any) {
        //let add = heightSelected + weightSelected
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "temp2ViewController") as! temp2ViewController
        myVC.IntPassed = i
        navigationController?.pushViewController(myVC, animated: true)
            }
    
    
    
    
    
    @IBOutlet weak var ProfileImage: UIImageView!
            
    
    @IBAction func Logout(_ sender: Any ) {
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: key_uid)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: nil)
     
       /*
        
        UserDefaults.standard.removeObject(forKey: "usersigned")
        UserDefaults.standard.synchronize()
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUpVc")
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signUp
        
        delegate.rememberLogin()
         
         */
        
        
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        loggedinuser()
        
        
        heightPickerView.delegate = self
        heightPickerView.dataSource = self
        
        weightPickerView.dataSource = self
        weightPickerView.delegate = self
    
        heightPickerView.tag = 1
        weightPickerView.tag = 2
        
        //if heightLabel.text != nil && weightLabel.text != nil {
          // var i =  add(weightSelected: weightLabel.text!, heightSelected: //heightLabel.text!)
       // }
        
    }
    
    func loggedinuser() {
        if Auth.auth().currentUser?.uid != nil
        {
            let uid = Auth.auth().currentUser?.uid

            Database.database().reference().child("User").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
             
                if !snapshot.exists() { return}
                
                let dictionary = snapshot.value as! NSDictionary
            
                print (snapshot)
                let downloadURL = (dictionary["profileImageURL"] as! String)
                print (downloadURL)
                self.loadingImageFromDatabase(downloadURL: downloadURL)
                
            
         })

            
        }
    }
    
    func loadingImageFromDatabase(downloadURL: String) {
        let storageRef = Storage.storage().reference(forURL: downloadURL)
        storageRef.downloadURL { (url, error) in
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) { self.ProfileImage.image = image }
            }
            
            
            
            
            
            //let image = UIImage(data: data as! Data)
            //self.ProfileImage.image = image
        }
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is temp2ViewController
        {
            var secondScene =  segue.destination as? temp2ViewController
        // Pass the selected object to the new view controller.
            text = weightSelected + heightSelected
            secondScene.text = text     }
    }*/
    

}

