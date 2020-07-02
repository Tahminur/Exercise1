//
//  MainTabController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS
import Firebase

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLoggedInUser()
    }
    
    
    func authenticateLoggedInUser(){
        //If user not logged in go to loginviewcontroller otherwise homeview
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            setupTabs()
        }
    }
    
    
    func templateNavController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .gray
        return nav
    }
    func setupTabs(){
        
        let cases = CountryCaseController()
        let tab1 = templateNavController(image: #imageLiteral(resourceName: "rona"), rootViewController: cases)
        
        let map = MapController()
        let tab2 = templateNavController(image: #imageLiteral(resourceName: "globe"), rootViewController: map)
        
        let signout = SignOutController()
        let tab3 = templateNavController(image: UIImage.init(systemName: "person"), rootViewController: signout)
        
        viewControllers = [tab1, tab2, tab3]
    }


}
