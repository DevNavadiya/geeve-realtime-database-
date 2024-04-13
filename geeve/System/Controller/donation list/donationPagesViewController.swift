//
//  donationPagesViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 14/03/24.
//

import UIKit
import SideMenu
import FirebaseDatabase


class donationPagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var userin = UserDefaults.standard
    var ref = DatabaseReference.init()
    @IBOutlet weak var tabelview: UITableView!
    var arrOfData = [usermodel]()
    override func viewDidLoad() {
        super.viewDidLoad()
       getRealTimeUserData()
        self.tabelview.delegate = self
        self.tabelview.dataSource = self
        self.tabelview.register(UINib(nibName: "donationPagesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "donationPagesCellTableViewCell")
        
        userdata.sherd.dataChangedHandler = { [weak self] in
            //               self?.dataFromeFirebaseHelper = userdata.sherd.sharDataFromeGetdata()
            self?.tabelview.reloadData()
        }
        
        // Fetch the initial data
        userdata.sherd.getdata(noindata: "")
        
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataFromeFirebaseHelper.count
        return arrOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "donationPagesCellTableViewCell") as! donationPagesCellTableViewCell
        
       let index = arrOfData[indexPath.row]
        
        
        cell.name.text = index.name
        cell.age.text = index.Email
        
//        self.tabelview.reloadData()



         cell.onDeleteButtonTapped = {
          
             let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete? You cannot undo this action.", preferredStyle: .alert)
             let btn = UIAlertAction(title: "Delete", style: .destructive) {_ in
                 
                 guard let indexpath = self.tabelview.indexPath(for: cell) else { return }
                 let userid = index.Email
//                 self.deleteUser(userID: userid)
                 self.tabelview.reloadData()
             }
             alert.addAction(btn)
             let btn1 = UIAlertAction(title: "Cancel", style: .cancel) { btn1 in
                 self.dismiss(animated: true)
                 
             }
             alert.addAction(btn1)
             self.present(alert, animated: true)
             

        }
        
        cell.oneditbuttontap = {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sing_Page_ViewController") as! sing_Page_ViewController
            
            vc.shoudhideui = true
            
            vc.firestname = index.name
            vc.lastname = index.lastname
            vc.email = index.Email
            vc.pass = index.Password
            vc.phone = index.phonenumber
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
      
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "chatScrrenViewController") as! chatScrrenViewController
        let index = arrOfData[indexPath.row]
        vc.nameofuser = index.name
        vc.reciver = index.Email
        vc.senderid = defultdata.sher.getemail()
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
@IBAction func sidebar(_ sender: Any) {
        
        setSideMenu()
       
    }
    
   
}

extension donationPagesViewController {
    
    func setSideMenu() {
        
        let x = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "customeSideBarViewController") as! customeSideBarViewController
        x.singouut = {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mainViewController") as! mainViewController
                  
            self.dismiss(animated: true)
            UserDefaults.standard.setValue(false, forKey: "USERIN")
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
        
        
        let menu = SideMenuNavigationController(rootViewController: x)
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: x)
      
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        leftMenuNavigationController.menuWidth = min(view.frame.width * 0.8, 320)
       
       
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
      
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view , forMenu: .left)
        
       
        
        
        present(leftMenuNavigationController, animated: true, completion: nil)
        
    }
      func getRealTimeUserData() {
       
       

        self.ref = Database.database().reference()
        self.ref.child("User").observe(.value) { snapshot in
           
            self.arrOfData.removeAll()
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let value = snap.value as? NSDictionary
                let name = value?["name"] as? String
                let lastname = value?["lastname"] as? String
                let email = value?["Email"] as? String
                let phonenumber = value?["phonenumber"] as? String
                let password = value?["Password"] as? String
                let confirmPassword = value?["conformPassword"] as? String
                
                
                
                self.arrOfData.append(usermodel(name: name!, lastname: lastname!, Email: email!, phonenumber: phonenumber!, Password: password!, conformPassword: confirmPassword!))
                
                for (index, userData) in self.arrOfData.enumerated() {
                    if userData.Email == defultdata.sher.getemail() {
                        self.arrOfData.remove(at: index)
                    }
                }
                       
            }
            
        DispatchQueue.main.async {
                      self.tabelview.reloadData()
                  }
            print("prinnt arr  \(self.arrOfData)")
        }
    }

    
//    func deleteUser(userID: String) {
//        if userID == "" {
//            print("user email is nill")
//        }else{
//            let ref = Database.database().reference().child("User/\(userID)")
//            ref.removeValue { error , demo in
//                if let error = error {
//                    print("Error deleting user: \(error.localizedDescription)")
//                } else {
//                    // User deleted successfully
//                    // You can optionally update the table view here to reflect the deletion
//                }
//            }
//        }
//    }
}
