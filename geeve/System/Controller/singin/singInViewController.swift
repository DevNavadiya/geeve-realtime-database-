//
//  singInViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 13/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

class singInViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var remember_me: UIButton!
    
    @IBOutlet weak var eye: UIButton!
    var id = ""
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
        guard let email = email.text, !email.isEmpty,
              let password = pass.text, !password.isEmpty else {
            
            return
        }
        checkCredentialsAndSignIn(email: email, password: password)
      
    }
    

  
    func checkCredentialsAndSignIn(email: String, password: String) {
        checkCredentialsExists(email: email, password: password) { emailExists, passwordExists in
            if emailExists && (passwordExists) {
                // Email-password combination exists in the database, sign in the user
                Auth.auth().signIn(withEmail: email, password: password) { user, error in
                    if let error = error {
                        print("Sign in error:", error.localizedDescription)
                        // Handle sign in error
                    } else {
                        // User signed in successfully
                        print("User signed in successfully")
                        if let userInfo = Auth.auth().currentUser {
                            let userID = userInfo.uid
                            print("User ID:", userID)
                            // Navigate to the next screen
                            self.navigateToNextScreen()
                        }
                    }
                }
            } else {
                // Show separate alerts for email and password
                if !emailExists {
                    self.showAlert(title: "Invalid Email", message: "The provided email address is incorrect.")
                }
                if !passwordExists {
                    self.showAlert(title: "Invalid Password", message: "The provided password is incorrect.")
                }
            }
        }
    }

    
        
    func checkCredentialsExists(email: String, password: String, completion: @escaping (Bool, Bool) -> Void) {
        let ref = Database.database().reference().child("User")
        ref.observeSingleEvent(of: .value) { snapshot in
            var emailExists = false
            var passwordExists = false
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                if let userData = snap.value as? [String: Any],
                   let userEmail = userData["Email"] as? String,
                   let userPassword = userData["Password"] as? String {
                    if userEmail == email {
                        emailExists = true
                    }
                    if userPassword == password {
                        passwordExists = true
                    }
                }
            }
            completion(emailExists, passwordExists)
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


