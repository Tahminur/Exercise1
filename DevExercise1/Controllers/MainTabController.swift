//
//  MainTabController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    
    func templateNavController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .gray
        return nav
    }
    func setupTabs(){
        //just need to fix positioning
        let cases = CountryCaseController()
        let tab1 = templateNavController(image: #imageLiteral(resourceName: "rona"), rootViewController: cases)
        
        let map = MapController()
        let tab2 = templateNavController(image: #imageLiteral(resourceName: "globe"), rootViewController: map)
        
        let newMap = MapViewController()
        let newMapTab = templateNavController(image: #imageLiteral(resourceName: "globe"), rootViewController: newMap)
        
        viewControllers = [tab1, tab2, newMapTab]
    }


}
