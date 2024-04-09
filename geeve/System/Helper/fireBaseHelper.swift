//
//  fireBaseHelper.swift
//  geeve
//
//  Created by Dev Navadiya on 22/03/24.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseAuth


    

let databaase = Firestore.firestore()
   


func login (Email : String , Password : String) {
        
        let collection = databaase.collection("loginUser")
        
        collection.document(Email).setData(["Email" : Email , "Password" : Password])
        
    }
    
    
    func saveUserData (name : String , lastname : String , Email : String , phonenumber : String , Password : String , id : String) {
        
        let database = Firestore.firestore()
        let collection = database.collection("Userinfo")
        collection.document(Email).setData(["name" : name ,
                                            "lastname" : lastname ,
                                            "Email" : Email ,
                                            "phonenumber" : phonenumber ,
                                            "Password" : Password ,
                                            "UId" : id ])
        
        
    }
    
    
    
class userdata {
    
    static let sherd = userdata()
    
    typealias DataChangedHandler = () -> Void
       var dataChangedHandler: DataChangedHandler?

   
    struct firebaseuser {
        var id = String()
        var UserName = String()
        var Email = String()
        var lastname = String()
        var password = String()
        var phonenumber = String()
        
        
        init(dic : [String : Any], documentId: String) {
            self.id = documentId
            self.UserName = dic["name"] as? String ?? ""
            self.Email = dic["Email"] as? String ?? ""
            self.lastname = dic["lastname"] as? String ?? ""
            self.password = dic["Password"] as? String ?? ""
            self.phonenumber = dic["phonenumber"] as? String ?? ""
           
        }
        
        
    }
    
    var firedata = [firebaseuser]()
    let databaase = Firestore.firestore()
    var firedata2 : firebaseuser!

    func getdata(noindata: String) {
        let document = databaase.collection("Userinfo")
        document.whereField("Email", notIn: [defultdata.sher.getnotindata()!]).getDocuments { quary, error in
            if error != nil {
                print("nodata")
            } else {
                self.firedata.removeAll() // Clear the `firedata` array
                let arr = quary?.documents
                for doc in arr! {
                                let documentId = doc.documentID
                                self.firedata2 = firebaseuser(dic: doc.data(), documentId: documentId)
                                self.firedata.append(self.firedata2)
                    
                            }
                self.dataChangedHandler?()
            }
        }
    }
    
    
    func sharDataFromeGetdata () -> [firebaseuser] {
        
        return firedata
    }
    
    
    func deleteDocument(documentId: String, completion: @escaping (Error?) -> Void) {
        databaase.collection("Userinfo").document(documentId).delete { error in
            completion(error)
        }
    }

//    func appenddatatorealm () {
//        
//        for firebaseuser in firedata {
//            let data = datafromefirebaseToRealm(userid: firebaseuser.id, userName: firebaseuser.UserName, email: firebaseuser.Email, lastName: firebaseuser.lastname, password: firebaseuser.password, phoneNumber: firebaseuser.phonenumber)
//            realmdata.append(data)
//            realmdatabasehelper.shard.savedata(data: data)
//            
//        }
//        print(realmdata)
//        
//    }
//   
}
