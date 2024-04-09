//
//  userdefullt.swift
//  geeve
//
//  Created by Dev Navadiya on 29/03/24.
//

import UIKit

class defultdata {
    
    static let sher = defultdata()
    
    
    let defult = UserDefaults.standard
    
    
    func setname (firestname : String) {
        
        defult.set(firestname, forKey: "firestname")
    }
    
    func getname () -> String? {
        
        return defult.string(forKey: "firestname")
    }
    
    
    
    func setlastname (lastname : String) {
        
        defult.set(lastname, forKey: "lastname")
    }
    
    func getlastname () -> String? {
        
        return  defult.string(forKey: "lastname")
        
    }
    
    
    
    func setphoneNumber (phonenumber : String) {
        
        defult.set(phonenumber, forKey: "phonenumber")
        
    }
    
    func getphoneNumber () -> String? {
        
        return  defult.string(forKey: "phonenumber")
        
    }
    
    
    func setpassword (password : String) {
        
        defult.set(password, forKey: "password")
    }
    
    func getpassword () -> String? {
        
        return  defult.string(forKey: "password")
        
    }
    
    func setemail (email : String) {
        defult.set(email, forKey: "email")
    }
    
    
    func getemail () -> String? {
        
        return  defult.string(forKey: "email")
        
    }
    
    func setnotindata (notindata : String) {
        
        defult.set(notindata, forKey: "notindata")
    }
    
    func getnotindata () -> String? {
        
        return defult.string(forKey: "notindata")
    }
    
    
    
    func setlogindata (notindata : String) {
        
        defult.set(notindata, forKey: "email")
    }
    
    func getlogindata () -> String? {
        
        return defult.string(forKey: "email")
    }
    
    func setloginpass (notindata : String) {
        
        defult.set(notindata, forKey: "pass")
    }
    
    func getloginpass () -> String? {
        
        return defult.string(forKey: "pass")
    }
    
    
}
