//
//  singInViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 13/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class singInViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var remember_me: UIButton!
    
    @IBOutlet weak var eye: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - remeber mi butoon condition -
    
    @IBAction func remember_Mi_Btn(_ sender: Any) {
        
        
        if  !remember_me.isSelected == true {
            
            let image = UIImage(named: "cutome")
            
            self.remember_me.setImage(image, for: .normal)
            print("tap")
            
        }else{
            
            let image = UIImage(named: "Image 4")
            
            self.remember_me.setImage(image, for: .normal)
            print("not tap")
        }
        remember_me.isSelected.toggle()
        
        
        
        // MARK: - singupbtn conditon -
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = self.email.text, !email.isEmpty,
              let password = self.pass.text, !password.isEmpty else {
            if email.text!.isEmpty{ showAlert(title: "email", message: "Please enter email.") }else{
                showAlert(title: "Password", message: "Please enter Password.")
            }
            return
        }
        let db = Firestore.firestore()
        let userInfoRef = db.collection("Userinfo").document(email)
        
        userInfoRef.getDocument { [weak self] (document, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                strongSelf.showAlert(title: "Error", message: "Failed to authenticate. Please try again.")
                return
            }
            
            guard let document = document, document.exists else {
                strongSelf.showAlert(title: "User Not Exist", message: "User not found.")
                return
            }
            let userData = document.data()
            if let storedPassword = userData?["Password"] as? String, storedPassword == password {
                
                strongSelf.navigateToNextScreen()
            } else {
                strongSelf.showAlert(title: "Password Not Exist", message: "Incorrect password.")
            }
        }
    }
    
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func navigateToNextScreen() {
        defultdata.sher.setlogindata(notindata: self.email.text ?? "")
        defultdata.sher.setloginpass(notindata: self.email.text ?? "")
        
        print("userlogin")
        
        let userinfo = Auth.auth().currentUser
        login(Email: self.email.text ?? "", Password: self.pass.text ?? "" )
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationViewController") as! registrationViewController
      
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //    MARK: - forgatpassbtn conditon -
    
    @IBAction func forgat_Pass_Btn(_ sender: Any) {
        
        navigateToViewController(main: "Main", storyboard: "forgetPasswordViewController", navigationController: self.navigationController)
        
    }
    
    // MARK: -  singinbtn conditon -
    
    @IBAction func sing_In_Btn(_ sender: Any) {
        navigateToViewController(main: "Main", storyboard: "sing_Page_ViewController", navigationController: self.navigationController)
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "donationPagesViewController") as! donationPagesViewController
        
        vc.userin.set(true, forKey: "USERIN")
        
    }
    
    @IBAction func eye(_ sender: Any) {
        
        if !eye.isSelected == true {
            self.pass.isSecureTextEntry = true
        }
        else {
            self.pass.isSecureTextEntry = false
        }
        
        eye.isSelected.toggle()
        
    }
}

extension singInViewController {
    
    func checkEmailExistence(_ email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("Userinfo").whereField("Email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking email existence: \(error.localizedDescription)")
                completion(false)
            } else {
                if let snapshot = snapshot, !snapshot.documents.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func checkPassword(_ email: String, _ password: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("Userinfo").whereField("Email", isEqualTo: email).whereField("Password", isEqualTo: password).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking password: \(error.localizedDescription)")
                completion(false)
            } else {
                if let snapshot = snapshot, !snapshot.documents.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
