//
//  loginViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class loginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utility.textField(emailText)
        Utility.textField(passwordText)
        Utility.FilledButton(loginButton)
        
    }
    


    @IBAction func loginTapped(_sender:Any){
        
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                self.transitionToHome()
            }
        }
        
    }
    
    func transitionToHome() {
        
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: Constants.storyboard.profileViewController) as? profileViewController
        
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()

    }

}
