//
//  ViewController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/24/22.
//

import UIKit

class SignInPageController: UIViewController {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInClickedAction(_ sender: UIButton) {
        print("\(#function)")
        if (usernameOutlet.text!.isEmpty && passwordOutlet.text!.isEmpty) {
            
        } else {
            self.performSegue (withIdentifier: "navigateToCreateProfileUI", sender: self)
        }
    }
    
    @IBAction func signUpClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToSignUp", sender: self)
    }
    

}

