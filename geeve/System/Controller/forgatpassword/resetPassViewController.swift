//
//  resetPassViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 13/03/24.
//

import UIKit

class resetPassViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var newpassword: UITextField!
   
    @IBOutlet weak var conformpass: UITextField!
    
    @IBOutlet weak var ieyebtn: UIButton!
    
    @IBOutlet weak var ieybtn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func eyebtn(_ sender: Any) {
        
        
        
        if !ieyebtn.isSelected == true {
            self.newpassword.isSecureTextEntry = true
        }
        else {
            self.newpassword.isSecureTextEntry = false
        }
        
        ieyebtn.isSelected.toggle()
        
    }
    
    
    @IBAction func eyebtn2(_ sender: Any) {
        
        if !ieybtn2.isSelected == true {
            self.conformpass.isSecureTextEntry = true
        }
        else {
            self.conformpass.isSecureTextEntry = false
        }
        
        ieybtn2.isSelected.toggle()
        
        
    }
    
    @IBAction func submit_btn(_ sender: Any) {
        
        if newpassword.text != conformpass.text {
            
            let allert = UIAlertController(title: "Password Doesn't Match", message: "Plese chake your conform Password It Was Not Similar", preferredStyle: .alert)
            
            let btn1 = UIAlertAction(title: "OK", style: .destructive)
            allert.addAction(btn1)
            self.present(allert, animated: true)
            self.conformpass.text = ""
            
        }
       
        else{navigateToViewController(main: "Main", storyboard: "registrationViewController", navigationController: self.navigationController)
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
   
}
