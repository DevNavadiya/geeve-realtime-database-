//
//  customeSideBarViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 14/03/24.
//

import UIKit

class customeSideBarViewController: UIViewController {
    
    var singouut : (() -> Void)?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var sideview: UIView!
    
    @IBOutlet weak var backbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        name.text = defultdata.sher.getname()
        email.text = defultdata.sher.getemail()
    }
    
    
    @IBAction func button(_ sender: Any) {
        
        
        self.dismiss(animated: true)
        
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        self.singouut?()
       
        
    }
    
    
}
