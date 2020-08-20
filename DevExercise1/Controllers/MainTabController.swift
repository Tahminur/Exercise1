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

    lazy var appDIContainer: AppDIContainer = {
        return (UIApplication.shared.delegate as! AppDelegate).appDIContainer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigure()
        //setupTabs()
        self.tabBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        self.tabBar.tintColor = .white
    }
//need to change for when remember me is available to check for credential = nil or not
    func authenticateUserAndConfigure() {
        if nil == nil {
            DispatchQueue.main.async {
                let loginController = self.appDIContainer.userContainer.makeLoginViewController()
                let nav = UINavigationController(rootViewController: loginController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            setupTabs()
        }
    }

    func setupTabs() {
        let newMap = appDIContainer.mapContainer.makeMapViewController()
        let newMapTab = templateNavController(image: #imageLiteral(resourceName: "globe"), rootViewController: newMap)
        let newCases = appDIContainer.countryContainer.makeCountryController()
        let newCasesTab = templateNavController(image: #imageLiteral(resourceName: "29-2"), rootViewController: newCases)
        //to be changed
        let signOut = appDIContainer.userContainer.makeSignOutController()
        let signOutTab = templateNavController(image: UIImage(systemName: "person"), rootViewController: signOut)
        viewControllers = [newCasesTab, newMapTab, signOutTab]
    }

    func templateNavController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.hidesBarsOnSwipe = true
        return nav
    }
}
