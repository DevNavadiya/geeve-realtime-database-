//
//  webViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 21/03/24.
//

import UIKit
import WebKit

class webViewController: UIViewController {
    
    
    @IBOutlet weak var web: WKWebView!
    
    let url = URL(string: "https://developer.apple.com/app-store/app-privacy-details/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        web.load(URLRequest(url: url!))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        
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
