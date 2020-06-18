//
//  MainTabController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        // Do any additional setup after loading the view.
    }
    
    
    func setupTabs(){
        
        let cases = CountryCaseController()
        cases.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        //figure out how to fix this tab so the picture actually appears, most likely a sizing issue in part of the image.
        let map = MapController()
        map.tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "globe"), tag: 1)
        
        
        
        viewControllers = [cases, map]
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
