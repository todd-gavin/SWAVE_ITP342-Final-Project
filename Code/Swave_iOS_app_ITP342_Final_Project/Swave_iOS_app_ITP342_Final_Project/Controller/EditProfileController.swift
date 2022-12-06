//
//  EditProfileController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/30/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

class EditProfileController: UIViewController, CLLocationManagerDelegate {

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
    
    let locationManager = CLLocationManager()
    
    private var userModel = UserModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationUIViewOutlet.layer.cornerRadius = 10
        primaryLocationUIViewOutlet.layer.cornerRadius = 10
        surferInformationUIViewOutlet.layer.cornerRadius = 10
        
        // For demo purposes only!!!
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // in meters
          
        // Notify us every 100th meters since last location update
        locationManager.distanceFilter = 100
        
        locationManager.delegate = self
        
        print("\(#function) Edit Profile Page")
        // Do any additional setup after loading the view.
    }
    
    func getCurrentLocation() {

        // Asking for permissions to access location
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with retrieving location: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print("First location: \(String(describing: locations.first))")
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            print("The user current location is \(lat),\(lng)")
            
            userModel.setLocationLat(lat: lat)
            userModel.setLocationLong(long: lng)
            
            latOutlet.text = String(userModel.getLocationLat())
            longOutlet.text = String(userModel.getLocationLong())
            
        }
        
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
    
    @IBAction func getCurrentLocationClickedAction(_ sender: UIButton) {
        getCurrentLocation()
    }

}
