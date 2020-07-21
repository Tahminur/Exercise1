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
        self.tabBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.tabBar.tintColor = .white
    }
    
    
    func templateNavController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.hidesBarsOnSwipe = true
        return nav
    }
    func setupTabs(){
        let newMap = MapViewController()
        let newMapTab = templateNavController(image: #imageLiteral(resourceName: "globe"), rootViewController: newMap)
        
        let newCases = CountryController()
        let newCasesTab = templateNavController(image: #imageLiteral(resourceName: "29-2"), rootViewController: newCases)
        viewControllers = [newCasesTab, newMapTab]
    }
}
