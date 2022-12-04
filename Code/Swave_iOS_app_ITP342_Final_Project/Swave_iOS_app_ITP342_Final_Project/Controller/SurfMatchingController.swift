//
//  SurfMatchingControllerViewController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/1/22.
//

import UIKit

class SurfMatchingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) Match and Event Info Page")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moreInfoClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToUserMatchInfo", sender: self)
    }
    
    @IBAction func confirmEventClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToEventCreation", sender: self)
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
