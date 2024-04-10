//
//  RealTimeDataBaseHelper.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import Foundation
import UIKit
import FirebaseDatabase


struct usermodel {
    var name : String
    var lastname : String
    var Email : String
    var phonenumber : String
    var Password : String
    var conformPassword : String
    
    init(name: String, lastname: String, Email: String, phonenumber: String, Password: String, conformPassword: String) {
        self.name = name
        self.lastname = lastname
        self.Email = Email
        self.phonenumber = phonenumber
        self.Password = Password
        self.conformPassword = conformPassword
    }
}



class realltimeuserdata {
    
    static let sher = realltimeuserdata()
    
  
    var ref = DatabaseReference.init()
    
    
    func saveuserdata (name : String , lastname : String , Email : String , phonenumber : String , Password : String , conformPassword : String) {
        self.ref = Database.database().reference()
        let dictionary = ["name" : name , "lastname" : lastname , "Email" : Email , "phonenumber" : phonenumber , "Password" : Password , "conformPassword" : conformPassword]
        self.ref.child("User").childByAutoId().setValue(dictionary)
    }
    
    
}



