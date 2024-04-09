////
////  realm database helper.swift
////  geeve
////
////  Created by Dev Navadiya on 01/04/24.
////
//
//import Foundation
//import UIKit
//import RealmSwift
//
//
//
//
//class datafromefirebaseToRealm : Object {
//    
//       @Persisted(primaryKey: true) var id: String = ""
//       @Persisted var userName: String = ""
//       @Persisted var email: String = ""
//       @Persisted var lastName: String = ""
//       @Persisted var password: String = ""
//       @Persisted var phoneNumber: String = ""
//    convenience init(userid: String, userName: String, email: String, lastName: String, password: String, phoneNumber: String) {
//        self.init()
//        self.id = userid
//        self.userName = userName
//        self.email = email
//        self.lastName = lastName
//        self.password = password
//        self.phoneNumber = phoneNumber
//    }
//    
//}
//
//var realmdata = [datafromefirebaseToRealm]()
//
//class realmdatabasehelper {
//    
//    static let shard = realmdatabasehelper()
//    
//    let realm = try! Realm()
//    
//    
//    
//    func getdatabaseurl () -> URL? {
//        return Realm.Configuration.defaultConfiguration.fileURL
//    }
//    
//    func savedata (data : datafromefirebaseToRealm) {
//        if let existingObject = realm.object(ofType: datafromefirebaseToRealm.self, forPrimaryKey: data.id) {
//            // Object with the same primary key value already exists, handle it accordingly
//            // For example, you might update the existing object with new data
//            try! realm.write {
//                existingObject.userName = data.userName
//                existingObject.email = data.email
//                // Update other properties as needed
//            }
//        } else {
//            // Object with the same primary key value doesn't exist, add a new one
//            try! realm.write {
//                realm.add(data)
//            }
//        }
//    }
//    
//    
//    func dataMatcherFirebaseToRealmdatabase() {
//        let firebaseData = userdata.sherd.sharDataFromeGetdata()
//        let realmData = Array(realm.objects(datafromefirebaseToRealm.self))
//        
//        let firebaseIds = Set(firebaseData.map { $0.id })
//        let realmIds = Set(realmData.map { $0.id })
//        
//        let idsToRemoveFromRealm = realmIds.subtracting(firebaseIds)
//        
//      
//        for id in idsToRemoveFromRealm {
//            if let userToDelete = realmData.first(where: { $0.id == id }) {
//                try! realm.write {
//                    realm.delete(userToDelete)
//                }
//            }
//        }
//    }
//
//    
//}
//
