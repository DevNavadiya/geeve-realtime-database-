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
    var userID: String?
    var name : String
    var lastname : String
    var Email : String
    var phonenumber : String
    var Password : String
    var conformPassword : String
    
    init(userID: String?, name: String, lastname: String, Email: String, phonenumber: String, Password: String, conformPassword: String) {
        self.userID = userID
        self.name = name
        self.lastname = lastname
        self.Email = Email
        self.phonenumber = phonenumber
        self.Password = Password
        self.conformPassword = conformPassword
    }
}



struct Chat {
    var senderID: String
    var receiverID: String
    var message: String
    var timestamp: Date
    
    init(senderID: String, receiverID: String, message: String, timestamp: Date) {
        self.senderID = senderID
        self.receiverID = receiverID
        self.message = message
        self.timestamp = timestamp
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



