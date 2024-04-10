//
//  chatScrrenViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import UIKit
import FirebaseDatabase

class chatScrrenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var chatTextFIled: UITextField!
    @IBOutlet weak var chatSenderButton: UIButton!
    var nameofuser : String?
    let database = Database.database().reference()
    
 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.text = nameofuser ?? "void"
        self.tabelview.delegate = self
        self.tabelview.dataSource = self
        self.tabelview.register(UINib(nibName: "SenderTableViewCell", bundle: nil), forCellReuseIdentifier: "SenderTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelview.dequeueReusableCell(withIdentifier: "SenderTableViewCell") as! SenderTableViewCell
      
    return cell
        }
    
    @IBAction func send_btn(_ sender: Any) {
      
    }
    
    @IBAction func back_btn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
