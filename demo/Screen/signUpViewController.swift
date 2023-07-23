//
//  signUpViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class signUpViewController: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utility.textField(userNameText)
        Utility.textField(emailText)
        Utility.textField(passwordText)
        Utility.FilledButton(signUpButton)
        
    }
    
    func validateFields() -> String?{
        
        if userNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields that require."
        }
        if emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields that require."
        }
        if passwordText.text? .trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields that require."
        }
        
        let cleanPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utility.isPasswordValid(cleanPassword) == false {
            return "Your Password need to contain at least 8 characters,  a special character and numbers."
        }
        
        

        return nil
    }
    


    @IBAction func signUpTapped(_sender:Any){
        
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else{
            
            let userName = userNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password){ (result, err) in
                if err != nil{
                    self.showError("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["userName":userName, "uid":result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("Can't found this user in our system")
                        }
                    }
                    
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1

    }
    
    func transitionToHome() {
        
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: Constants.storyboard.profileViewController) as? profileViewController
        
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()

    }

}
