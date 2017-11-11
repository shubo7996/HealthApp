//
//  temp2ViewController.swift
//  HealthApp
//
//  Created by Subhamoy Paul on 11/3/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

//var stringPassed = ""
class temp2ViewController: UIViewController {
    
    var IntPassed = i

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        print (IntPassed)
        self.loadingFromFirebase(i: Double(IntPassed))
        myLabel.text = String(IntPassed)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myLabel: UILabel!
    
   func loadingFromFirebase(i: Double) {
    /*
 Database.database().reference.child("User").child((Auth.auth.currentUser?.uid)!).observeSingleEvent(of: .value, with {(snapshot) in
    
    if !snapshot.exists() {return}
    
    let dictionary = snapshot.value as! NSDictionary
    
    let BMI = (dictionary["BMI"]as! Double)
    print(BMI)
    })*/
    
    
    
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
