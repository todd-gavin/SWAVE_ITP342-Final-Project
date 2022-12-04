//
//  profileController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/29/22.
//

import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    @IBOutlet weak var statusViewOutlet: UIView!
    @IBOutlet weak var surferLevelViewOutlet: UIView!
    @IBOutlet weak var boardTypeViewOutlet: UIView!
    @IBOutlet weak var locationViewOutlet: UIView!
    
    @IBOutlet weak var fullNameOutlet: UILabel!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var shortBioOutlet: UILabel!
    @IBOutlet weak var ageLabelOutlet: UILabel!
    
    @IBOutlet weak var latOutlet: UILabel!
    @IBOutlet weak var longOutlet: UILabel!
    
    @IBOutlet weak var experienceLevelOutlet: UILabel!
    @IBOutlet weak var boardTypeOutlet: UILabel!
    @IBOutlet weak var surfStatusOutlet: UILabel!
    
    private var userModel = UserModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusViewOutlet.layer.cornerRadius = 10
        surferLevelViewOutlet.layer.cornerRadius = 10
        boardTypeViewOutlet.layer.cornerRadius = 10
        locationViewOutlet.layer.cornerRadius = 10
//        self.navigationItem.setHidesBackButton(true, animated: true)
        updateProfileUI()
        print("\(#function) Profile Page")
        // Do any additional setup after loading the view.
    }
    
    func updateProfileUI() {
        fullNameOutlet.text = userModel.getFullName()
        usernameOutlet.text = userModel.getUsername()
        ageLabelOutlet.text = String(userModel.getAge())
        shortBioOutlet.text = userModel.getShortBio()
        
        if userModel.getSurfStatus() == 0 {
            surfStatusOutlet.text = "Open to Surf"
        } else if userModel.getSurfStatus() == 1 {
            surfStatusOutlet.text = "Surfing Today"
        } else if userModel.getSurfStatus() == 2 {
            surfStatusOutlet.text = "Surf Tomorrow"
        }
        
        if userModel.getSurfboardType() == 0 {
            boardTypeOutlet.text = "Shortboard"
        } else if userModel.getSurfStatus() == 1 {
            boardTypeOutlet.text = "Longboard"
        } else if userModel.getSurfStatus() == 2 {
            boardTypeOutlet.text = "Foamboard"
        }
        
        if userModel.getExperienceLevel() == 0 {
            experienceLevelOutlet.text = "Beginner"
        } else if userModel.getSurfStatus() == 1 {
            experienceLevelOutlet.text = "Intermediate"
        } else if userModel.getSurfStatus() == 2 {
            experienceLevelOutlet.text = "Advanced"
        }
            
        latOutlet.text = String(userModel.getLocationLat())
        longOutlet.text = String(userModel.getLocationLong())
        
        print("Profile UI Updated")
        
    }
    

    @IBAction func editProfileClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToEditProfile", sender: self)
    }
    
    @IBAction func signOutClickedAction(_ sender: UIButton) {
        print("\(#function)")
        do {
            try Auth.auth().signOut()
            print("Succesfully signed out of current user")
            // Need to reset all parameteres in userModel singleton
            self.performSegue (withIdentifier: "navigateBackToSignInPage", sender: self)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}
