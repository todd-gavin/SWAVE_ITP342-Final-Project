//
//  CreateProfileUIController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/28/22.
//

import UIKit

class CreateProfileController: UIViewController {

    @IBOutlet weak var userInformationUIViewOutlet: UIView!
    @IBOutlet weak var primaryLocationUIViewOutlet: UIView!
    @IBOutlet weak var surferInformationUIViewOutlet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInformationUIViewOutlet.layer.cornerRadius = 10
        primaryLocationUIViewOutlet.layer.cornerRadius = 10
        surferInformationUIViewOutlet.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedCreateProfileAction(_ sender: UIButton) {
        self.performSegue (withIdentifier: "navigateToHomeUI", sender: self)
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
