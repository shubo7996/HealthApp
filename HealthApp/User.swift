//
//  File.swift
//  
//
//  Created by Subhamoy Paul on 10/1/17.
//
//

import Foundation

class User {
    
    var email :String
    var uid :Int
    var username :String
    var fullname :String
    var profileImageUrl :String
    var height :Int
    var weight :Int
    
    init (dictionary: [String : AnyObject]) {
        
        self.email = (dictionary["email"] as? String)!
        self.uid = (dictionary["uid"] as? Int)!
        self.username = (dictionary["username"] as? String)!
        self.fullname = (dictionary["fullname"] as? String)!
        self.profileImageUrl = (dictionary["profileImageUrl"] as? String)!
        self.height = (dictionary["height"] as? Int)!
        self.weight = (dictionary["weight"] as? Int)!
        
    }
}
