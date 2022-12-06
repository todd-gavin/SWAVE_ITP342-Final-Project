//
//  HomeTabBarController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/30/22.
//

import UIKit

class HomeTabBarController: UITabBarController {

    @IBOutlet weak var navigationItemOutlet: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        print("\(#function) Home Page")
        // Do any additional setup after loading the view.
    }

}
