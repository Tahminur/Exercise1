//
//  SignOutController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/30/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignOutController:UIViewController{
    
    
    private let SignoutButton: UIButton = {
        let button = Util().buttoncreator(title: "Sign Out")
        button.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignout(){
        do {
            try Auth.auth().signOut()
            print("DEBUG: Logging out")
            DispatchQueue.main.async {
                //below makes sure upon next login the country cases controller is the main page
                self.tabBarController?.selectedIndex = 0
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(SignoutButton)
        SignoutButton.anchor(top:view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right:view.rightAnchor,paddingTop: 96,paddingLeft: 32,paddingRight: 32)
    }
}
