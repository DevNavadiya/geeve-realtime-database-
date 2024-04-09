//
//  donationPagesViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 14/03/24.
//

import UIKit
import SideMenu


class donationPagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var userin = UserDefaults.standard

    @IBOutlet weak var tabelview: UITableView!
//    var data = [UserSingUp]()
    var dataFromeFirebaseHelper = userdata.sherd.sharDataFromeGetdata()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(data)
        self.tabelview.delegate = self
        self.tabelview.dataSource = self
        self.tabelview.register(UINib(nibName: "donationPagesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "donationPagesCellTableViewCell")
      
        userdata.sherd.dataChangedHandler = { [weak self] in
               self?.dataFromeFirebaseHelper = userdata.sherd.sharDataFromeGetdata()
               self?.tabelview.reloadData()
           }
           
           // Fetch the initial data
           userdata.sherd.getdata(noindata: "")
       
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                       realmdatabasehelper.shard.dataMatcherFirebaseToRealmdatabase()
//                   }
        
    }
    
    
    
//    func syncData() {
//          // Synchronize Firebase and Realm data here
//          realmdatabasehelper.shard.dataMatcherFirebaseToRealmdatabase()
//      }
    

//    func relodedata () {
//        self.dataFromeFirebaseHelper = userdata.sherd.sharDataFromeGetdata()
//        self.tabelview.reloadData()
//        
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromeFirebaseHelper.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "donationPagesCellTableViewCell") as! donationPagesCellTableViewCell
        
        let index = dataFromeFirebaseHelper[indexPath.row]
        
        
        cell.name.text = index.UserName
        cell.age.text = index.Email
        cell.documentid = index.Email


         cell.onDeleteButtonTapped = { [weak self] in
               self?.deleteData(at: indexPath)
//            realmdatabasehelper.shard.dataMatcherFirebaseToRealmdatabase()
        }
        
        cell.oneditbuttontap = {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "sing_Page_ViewController") as! sing_Page_ViewController
            
            vc.shoudhideui = true
            
            vc.firestname = index.UserName
            vc.lastname = index.lastname
            vc.email = index.Email
            vc.pass = index.password
            vc.phone = index.phonenumber
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
      
        
    }
    
   
    
    func deleteData(at indexPath: IndexPath) {
        let documentId = dataFromeFirebaseHelper[indexPath.row].Email
        userdata.sherd.deleteDocument(documentId: documentId) { [weak self] error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                
                self?.dataFromeFirebaseHelper.remove(at: indexPath.row)
              
                self?.tabelview.reloadData()
                
                
//                realmdatabasehelper.shard.dataMatcherFirebaseToRealmdatabase()
            }
        }
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
  
    func reloadData() {
        userdata.sherd.getdata(noindata: "") // Fetch all data
        dataFromeFirebaseHelper = userdata.sherd.sharDataFromeGetdata()
        DispatchQueue.main.async {
            self.tabelview.reloadData()
            
            
                
              
            
            
        }
    }

}
