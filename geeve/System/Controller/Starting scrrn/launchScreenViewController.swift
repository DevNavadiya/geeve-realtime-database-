//
//  launchScreenViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 29/03/24.
//

import UIKit

class launchScreenViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if UserDefaults.standard.bool(forKey: "USERIN") == true {
            navigateToViewController(main: "Main", storyboard: "donationPagesViewController", navigationController: self.navigationController)
        }
        else {
            navigateToViewController(main: "Main", storyboard: "mainViewController", navigationController: self.navigationController)
        }
        
        
        
    
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
