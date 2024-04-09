//
//  forgetPasswordViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 13/03/24.
//

import UIKit

class forgetPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func sing_Up_btn(_ sender: Any) {
    
        if self.email.text?.isEmpty == true {
            let alert = UIAlertController(title: "Email", message: "Plese Enter You Email ", preferredStyle: .alert)
            
            let btn = UIAlertAction(title: "OK", style: .default)
            alert.addAction(btn)
            
            self.present(alert, animated: true)
            
        }
            else {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetPassViewController")
                
                
                self.navigationController?.pushViewController(vc, animated: true )
            }
            
            
        
        
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
}
