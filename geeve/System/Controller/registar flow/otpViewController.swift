//
//  otpViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 13/03/24.
//

import UIKit
import AEOTPTextField
import FirebaseAuth

class otpViewController: UIViewController {
   

    @IBOutlet weak var otp: AEOTPTextField!
     var getotp = ""
    var notindata = String()
   
//    let data = defultdata.sher
//    
//    var name = String()
//    var lastname = String()
//    var email = String()
//    var phonenumber = String()
//    var password = String()
//    var uid = String()
   var verificationID : String?
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
     
//        data.setname(firestname: name)
//        data.setlastname(lastname: lastname)
//        data.setemail(email: email)
//        data.setphoneNumber(phonenumber: phonenumber)
//        data.setpassword(password: password)
//        
        
        
        self.otp.otpDelegate = self
        otp.configure(with: 6)
        otp.otpFilledBorderColor = .orange
        otp.otpTextColor = .orange
        
//        otp.textColor = .orange
sendOTP()
    }
    
    func sendOTP() {
        PhoneAuthProvider.provider().verifyPhoneNumber(defultdata.sher.getphoneNumber() ?? "", uiDelegate: nil) { verificationID, error in
                if let error = error {
                    
                    print("Error verifying phone number:", error)
                    
                    let alert = UIAlertController(title: "Invalid OTP Number", message: "Please check your OTP. Your OTP did not match the sent OTP.", preferredStyle: .alert)
                    let btn1 = UIAlertAction(title: "OK", style: .destructive)
                    alert.addAction(btn1)
                    self.otp.text = ""
                    self.present(alert, animated: true)
                    
                    return
                }
                
                self.verificationID = verificationID
                guard let verificationID = verificationID else {
                    print("Verification ID is nil")
                    return
                }
                
                print("OTP Sent Successfully!")
            }
        }
    
    @IBAction func continu_btn(_ sender: Any) {
       
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        defultdata.sher.setnotindata(notindata: notindata)
        guard let verificationID = self.verificationID else {
                print("Verification ID is nil")
                return
            }
            
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: self.otp.text!)
        Auth.auth().signIn(with: credential) { (authdata, error) in
            if let error = error {
                print("Error signing in:", error)
                return
            }
//           
//            saveUserData(name: self.data.getname() ?? "", lastname: self.data.getlastname() ?? "" , Email: self.data.getemail() ?? "", phonenumber: self.data.getphoneNumber() ?? "", Password: self.password, id: self.uid)
//            
           
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "registrationViewController") as! registrationViewController
           
//            vc.notindata = self.email
            
            self.navigationController?.pushViewController(vc, animated: true)
            
             }
        }
    
    @IBAction func back_btn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension otpViewController:AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
        
        
        self.getotp = code
    }
}
