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
        
        var Final_result = BMI(i: IntPassed)
        myLabel.text = Final_result

        // Do any additional setup after loading the view.
    }

    @IBAction func Okay(_ sender: Any) {
        performSegue(withIdentifier: "Segue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myLabel: UILabel!
    
    func BMI(i: Int) -> String {
        if Double(i) < 18.5 {
            return "You are underweight"
        } else if Double(i) > 18.5 && Double(i) < 25 {
            return "You are normalweight"
        } else if Double(i) > 25 && Double(i) < 30 {
            return "You are overweight"
        } else { return "You are obese" }
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
