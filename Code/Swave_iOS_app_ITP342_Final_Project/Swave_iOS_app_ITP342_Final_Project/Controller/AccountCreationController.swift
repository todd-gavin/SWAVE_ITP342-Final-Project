//
//  AccountCreationController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/30/22.
//

import UIKit

class AccountCreationController: UIViewController {

    @IBOutlet weak var navigationItemOutlet: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        print("\(#function) Account Creation Page")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueToHomeClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToHome", sender: self)
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
