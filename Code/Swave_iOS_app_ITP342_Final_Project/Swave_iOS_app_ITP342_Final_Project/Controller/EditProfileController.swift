//
//  EditProfileController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/30/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditProfileController: UIViewController {

    @IBOutlet weak var userInformationUIViewOutlet: UIView!
    @IBOutlet weak var primaryLocationUIViewOutlet: UIView!
    @IBOutlet weak var surferInformationUIViewOutlet: UIView!
    
    @IBOutlet weak var fullNameOutlet: UITextField!
    @IBOutlet weak var shortBioOutlet: UITextField!
    @IBOutlet weak var ageSliderOutlet: UISlider!
    @IBOutlet weak var ageLabelOutlet: UILabel!
    
    @IBOutlet weak var latOutlet: UILabel!
    @IBOutlet weak var longOutlet: UILabel!
    
    @IBOutlet weak var experienceLevelOutlet: UISegmentedControl!
    @IBOutlet weak var boardTypeOutlet: UISegmentedControl!
    @IBOutlet weak var surfStatusOutlet: UISegmentedControl!
    
    var user_age = 18
    
    private var userModel = UserModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationUIViewOutlet.layer.cornerRadius = 10
        primaryLocationUIViewOutlet.layer.cornerRadius = 10
        surferInformationUIViewOutlet.layer.cornerRadius = 10
        print("\(#function) Edit Profile Page")
        // Do any additional setup after loading the view.
    }
    
    func validateProfileParameters() -> Bool {
        if (fullNameOutlet.text!.isEmpty || shortBioOutlet.text!.isEmpty) {
            return false
        } else {
            return true
        }
    }
    
    func updateCurrentUserModel() {
        userModel.setFullName(name: fullNameOutlet.text!)
        userModel.setShortBio(bio: shortBioOutlet.text!)
        userModel.setAge(age: self.user_age)
        userModel.setLocationLat(lat: 0)
        userModel.setLocationLong(long: 0)
        userModel.setExperienceLevel(level: experienceLevelOutlet.selectedSegmentIndex)
        userModel.setSurfboardType(board: boardTypeOutlet.selectedSegmentIndex)
        userModel.setSurfStatus(status: surfStatusOutlet.selectedSegmentIndex)
    }
    
    func pushToFirebase(id: String) {
        let ref = Firestore.firestore().collection("users").document(id)
        ref.updateData(["full_name":userModel.getFullName(),
                     "short_bio":userModel.getShortBio(),
                     "age":userModel.getAge(),
                     "primary_location_lat":userModel.getLocationLat(),
                     "primary_location_long":userModel.getLocationLong(),
                     "experience_level":userModel.getExperienceLevel(),
                     "board_type":userModel.getSurfboardType(),
                     "surf_status":userModel.getSurfStatus()
                    ])
    }
    
    @IBAction func ageSliderAction(_ sender: UISlider) {
        let age = Double(sender.value)
//        print("Age: \(Int(age))")
        self.user_age = Int(age)
        ageLabelOutlet.text = "\(user_age)"
        
    }
    
    @IBAction func cancelClickedAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmEditProfileClickedAction(_ sender: UIButton) {
        print("\(#function)")
        
        if validateProfileParameters() == true {
            
            self.updateCurrentUserModel()
            self.userModel.getAllUserInfoLocal()
            
            self.pushToFirebase(id: self.userModel.getUserID())
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "", message: "Please fill in all profile fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            print("User did not fill in all fields")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
