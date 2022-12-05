//
//  SignUpController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/28/22.
//

import UIKit
import FirebaseFirestore

class SignUpController: UIViewController {
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var confirmPasswordOutlet: UITextField!
    
    private var userModel = UserModel.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) Sign Up Page")
        print("\(userModel.getAllUserInfoLocal())")
    }
    
    @IBAction func backClickedAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpClickedAction(_ sender: UIButton) {
        print("\(#function) pt2")
        
        if (emailOutlet.text!.isEmpty || passwordOutlet.text!.isEmpty || confirmPasswordOutlet.text!.isEmpty) {
            
            let alert = UIAlertController(title: "", message: "Please fill in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (passwordOutlet.text! != confirmPasswordOutlet.text!) {
            let alert = UIAlertController(title: "Passwords do not match", message: "Please make sure both passwords match", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            userModel.setEmail(email: emailOutlet.text!)
            userModel.setPassword(password: passwordOutlet.text!)
            self.performSegue (withIdentifier: "navigateToCreateProfile", sender: self)
        }

    }

}
