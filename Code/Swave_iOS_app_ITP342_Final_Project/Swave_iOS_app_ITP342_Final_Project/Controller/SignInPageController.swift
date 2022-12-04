//
//  ViewController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/24/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignInPageController: UIViewController {
    
    private var userModel = UserModel.sharedInstance
    
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
//    Use viewWillAppear function to pull the latest data from firebase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) Sign In Page")
    }
    
    func pullFromFirebase_UpdateUserModelSingleton() -> Bool {
        
        if let user = Auth.auth().currentUser {
            let ref = Firestore.firestore().collection("users").document(user.uid)
            ref.getDocument { (snapshot, error) in
                
                if error == nil, let snapshot {
                    
                    self.userModel.setUserID(id: snapshot.documentID)
                    self.userModel.setEmail(email: user.email!)
                    self.userModel.setFullName(name: snapshot.data()!["full_name"] as! String)
                    self.userModel.setUsername(username: snapshot.data()!["username"] as! String)
                    self.userModel.setShortBio(bio: snapshot.data()!["short_bio"] as! String)
                    self.userModel.setAge(age: snapshot.data()!["age"] as! Int)
                    self.userModel.setLocationLat(lat: snapshot.data()!["primary_location_lat"] as! Float)
                    self.userModel.setLocationLong(long: snapshot.data()!["primary_location_long"] as! Float)
                    self.userModel.setExperienceLevel(level: snapshot.data()!["experience_level"] as! Int)
                    self.userModel.setSurfboardType(board: snapshot.data()!["board_type"] as! Int)
                    self.userModel.setSurfStatus(status: snapshot.data()!["surf_status"] as! Int)

                    print("userModel update complete from Firebase")
                    
                }
                else {
                    print("Error with pulling current user data: \(String(describing: error))")
                }
            }
            return true
            
        } else {
            return false
        }
    }
    
    
    @IBAction func signInClickedAction(_ sender: UIButton) {
        print("\(#function)")

        if (emailOutlet.text!.isEmpty || passwordOutlet.text!.isEmpty) {
            
            let alert = UIAlertController(title: "", message: "Please fill in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: emailOutlet.text!, password: passwordOutlet.text!) { (result, error) in
                
                if error == nil {
                    
                    print("User succesfully signed in with result: \(String(describing: result))")
                    let pullState = self.pullFromFirebase_UpdateUserModelSingleton()
                    print("Pullstate: \(pullState)")
                    if (pullState == false) {
                        print("Unsucessfull pull of data from firebase current user.")
                    } else {
                        self.performSegue (withIdentifier: "navigateToHomePage", sender: self)
                    }
                    
                } else {
                    
                    print("Failed to sign in user with error: \(String(describing: error))")
                    
                    let alert = UIAlertController(title: "Sign In Failed", message: "Email or Password do not match our records. Please try again.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
    }
    
    @IBAction func signUpClickedAction(_ sender: UIButton) {
        print("\(#function) pt1")
        self.performSegue (withIdentifier: "navigateToSignUp", sender: self)
    }
   
    //        let ref = Firestore.firestore().collection("users").document("testUser3")
            // setData rewrites everything
    //        ref.setData(["hello": "everyone"])
            // updateData just updates a specific field
            // ref.updateData(["field1": "c"])
    //
    //        // create document id with push keys
    //        Firestore.firestore().collection("users").addDocument(data: ["full_name": "Sean"])

}

