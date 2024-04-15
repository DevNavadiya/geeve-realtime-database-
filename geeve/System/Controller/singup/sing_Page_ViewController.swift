//
//  sing_Page_ViewController.swift
//  geeve App
//
//  Created by Dev Navadiiya on 29/02/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


class sing_Page_ViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var firest_Name_Texfild: UITextField!
    
    @IBOutlet weak var last_Name_TextFileld: UITextField!
    
    @IBOutlet weak var Email_Textfiled: UITextField!
    
    @IBOutlet weak var phone_number_textFild: UITextField!
    
    @IBOutlet weak var paswoord_Text_filed: UITextField!
    
    @IBOutlet weak var terms: UIButton!
    
    @IBOutlet weak var enter_conform_password_textfild: UITextField!
    
    @IBOutlet weak var tic_mark_Terms: UIButton!
    @IBOutlet weak var i_agerr: UILabel!
    @IBOutlet weak var alredyhave_account: UIButton!
    
    @IBOutlet weak var singin: UIButton!
    
    @IBOutlet weak var signup: UIButton!
    
    var id = ""
    
    var firestname : String?
    var lastname : String?
    var email : String?
    var phone : String?
    var pass : String?
    let data = defultdata.sher
    let database = Database.database().reference()
    var ref = Database.database().reference()
    var arrOfData = [usermodel]()
    
    func hideui () {
        self.tic_mark_Terms.isHidden = true
        self.i_agerr.isHidden = true
        self.terms.isHidden = true
        self.alredyhave_account.isHidden = true
        self.singin.isHidden = true
        self.Email_Textfiled.isUserInteractionEnabled = false
        self.phone_number_textFild.isUserInteractionEnabled = false
        signup.setTitle("UPDATE", for: .normal)
        self.tic_mark_Terms.isSelected = true
    }
    var shoudhideui = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.phone_number_textFild.keyboardType = .numberPad
        
        if shoudhideui {
            hideui()
            self.firest_Name_Texfild.text = firestname
            self.last_Name_TextFileld.text = lastname
            self.Email_Textfiled.text = email
            self.phone_number_textFild.text = phone
            self.paswoord_Text_filed.text = pass
            self.enter_conform_password_textfild.text = pass
            
        }
        
    }
    
    // MARK: - terms butoon condition -
    
    
    
    
    
    @IBAction func tic(_ sender: Any) {
        
        
        if  !tic_mark_Terms.isSelected == true {
            
            let image = UIImage(named: "cutome")
            
            self.tic_mark_Terms.setImage(image, for: .normal)
            print("tap")
            
        }else{
            
            let image = UIImage(named: "Image 4")
            
            self.tic_mark_Terms.setImage(image, for: .normal)
            print("not tap")
        }
        tic_mark_Terms.isSelected.toggle()
        
        
        
        
    }
    
    // MARK: - Sing UP condition -
    
    
    
    
    
    @IBAction func sing_Up_Btn(_ sender: Any) {
        
        if firest_Name_Texfild.text!.isEmpty || self.last_Name_TextFileld.text!.isEmpty || self.phone_number_textFild.text!.isEmpty || self.paswoord_Text_filed.text!.isEmpty || self.Email_Textfiled.text!.isEmpty || self.enter_conform_password_textfild.text!.isEmpty {
            let alert = UIAlertController(title: "Sign Up", message: "Please enter all details", preferredStyle: .alert)
            let btn1 = UIAlertAction(title: "OK", style: .default)
            alert.addAction(btn1)
            self.present(alert, animated: true)
            print("Button tapped")
        }
        
        if self.paswoord_Text_filed.text! != self.enter_conform_password_textfild.text {
            let alert = UIAlertController(title: "Password Doesn't Match", message: "Please check your confirm password. It was not similar.", preferredStyle: .alert)
            let btn1 = UIAlertAction(title: "OK", style: .destructive)
            alert.addAction(btn1)
            self.present(alert, animated: true)
            self.enter_conform_password_textfild.text = ""
        }
        
        if self.paswoord_Text_filed.text!.count < 6 {
            let alert = UIAlertController(title: "Password Range", message: "Please check your password. The minimum password length is 6 characters.", preferredStyle: .alert)
            let btn1 = UIAlertAction(title: "OK", style: .destructive)
            alert.addAction(btn1)
            self.present(alert, animated: true)
        }
        
        if tic_mark_Terms.isSelected == false {
            let alert = UIAlertController(title: "Terms And Conditions", message: "Please agree to our terms and conditions.", preferredStyle: .alert)
            let btn1 = UIAlertAction(title: "OK", style: .default)
            alert.addAction(btn1)
            self.present(alert, animated: true)
            print("Button tapped")
        }
        
        if shoudhideui == false {
            guard let email = Email_Textfiled.text, !email.isEmpty,
                  let password = paswoord_Text_filed.text, !password.isEmpty else {
                
                return
            }
            checkEmailExists(email:email) { [self] exists in
                if exists {
                    // Email already exists, show an alert
                    showAlert(title: "Email Already Exists", message: "The provided email address is already in use.")
                    
                } else {
                    // Email doesn't exist, proceed with sign up
                    acces()
                    
                    Auth.auth().createUser(withEmail: self.Email_Textfiled.text ?? "nil" , password: self.paswoord_Text_filed.text ?? "nil"){otheruser,error in
                        if let error = error as? NSError {
                            print(error.localizedDescription)
                        }else{
                            print("user rejister")
                            let userInfo = Auth.auth().currentUser
                            self.id = userInfo!.uid
                            print(self.id)
                        }
                        
                    }
                    
                }
            }
            
        }else{
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "donationPagesViewController") as! donationPagesViewController
            let newdata = [ "name" : self.firest_Name_Texfild.text! , "lastname" : self.last_Name_TextFileld.text! , "Email" : self.Email_Textfiled.text! , "phonenumber" : self.phone_number_textFild.text! , "Password" : self.paswoord_Text_filed.text! , "conformPassword" : enter_conform_password_textfild.text!]
            self.updateUser(userid: id, newData: newdata)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    func acces () {   let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationViewController") as! registrationViewController
        
        
        data.setname(firestname: self.firest_Name_Texfild.text ?? "")
        data.setlastname(lastname: self.last_Name_TextFileld.text ?? "")
        data.setemail(email: self.Email_Textfiled.text ?? "")
        data.setphoneNumber(phonenumber: self.phone_number_textFild.text ?? "")
        data.setpassword(password: self.paswoord_Text_filed.text ?? "")
        
        realltimeuserdata.sher.saveuserdata(name: self.data.getname() ?? "", lastname: self.data.getlastname() ?? "" , Email: self.data.getemail() ?? "", phonenumber: self.data.getphoneNumber() ?? "", Password: self.data.getpassword() ?? "", conformPassword: self.data.getpassword() ?? "")
        
        vc.notindata = self.Email_Textfiled.text ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true )
        
    }

    // MARK: - Singin -
    
    @IBAction func singin(_ sender: Any) {
        
        navigateToViewController(main: "Main", storyboard: "singInViewController", navigationController: self.navigationController)
        
    }
    
    @IBAction func privicy(_ sender: Any) {
        
        navigateToViewController(main: "Main", storyboard: "webViewController", navigationController: self.navigationController)
     
    }
    
    
    func updateUser(userid : String , newData : [String : Any]) {
        
        let ref = Database.database().reference().child("User").child(userid)
        ref.updateChildValues(newData) { error,_ in
            if let error = error {
                print("Error updating data:", error.localizedDescription)
            } else {
                print("Data updated successfully")
            }
        }
    }
}

extension sing_Page_ViewController {
    
    func checkEmailExists(email: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("User")
        ref.observeSingleEvent(of: .value) { snapshot in
            var emailExists = false
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                if let userData = snap.value as? [String: Any],
                   let userEmail = userData["Email"] as? String,
                   userEmail == email {
                    // Email exists in the database
                    emailExists = true
                    break
                }
            }
            completion(emailExists)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
