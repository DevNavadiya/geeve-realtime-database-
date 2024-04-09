//
//  registrationViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 14/03/24.
//

import UIKit
import SideMenu




class registrationViewController: UIViewController {
    @IBOutlet weak var donor_btn: UIButton!
    @IBOutlet weak var donee: UIButton!
    @IBOutlet weak var sidebar: UIButton!
//    var data = [UserSingIn]()
    
   
  
    
    
    
    enum animationtup {
        case slidein , slideout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.donor_btn.isSelected = true
        self.donor_btn.layer.borderWidth = 5
        self.donor_btn.layer.borderColor = UIColor.orange.cgColor

    }
    @IBAction func go_Btn(_ sender: Any) {
      
        
        if donee.isSelected == true || donor_btn.isSelected == true {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "customePopUpViewController") as! customePopUpViewController
            
          
            
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.clouser = {
               
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "donationPagesViewController") as! donationPagesViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                }
            self.present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "DONOR OR DONEE", message: "Plese select one option , you are DONOR or DONEE", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .cancel)
            
            alert.addAction(btn)
            
            self.present(alert, animated: true)
        }
    }
    @IBAction func donre_action(_ sender: UIButton) {
        
        if !sender.isSelected {
            // Select the sender button
            sender.isSelected = true
            sender.layer.borderWidth = 5
            sender.layer.borderColor = UIColor.orange.cgColor
            
            // Deselect the other button
            donee.isSelected = false
            donee.layer.borderWidth = 0
        } else {
            // Deselect the sender button
            sender.isSelected = false
            sender.layer.borderWidth = 0
        }
    }
    @IBAction func done_acttion(_ sender: UIButton) {
        if !sender.isSelected {
            // Select the sender button
            sender.isSelected = true
            sender.layer.borderWidth = 5
            sender.layer.borderColor = UIColor.orange.cgColor
            
            // Deselect the other button
            donor_btn.isSelected = false
            donor_btn.layer.borderWidth = 0
        } else {
            // Deselect the sender button
            sender.isSelected = false
            sender.layer.borderWidth = 0
        }
    }
    
    @IBAction func side_bar(_ sender: Any) {
        print("tap")
        setSideMenu()
    }
    
}



extension registrationViewController {
    
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
    
}
