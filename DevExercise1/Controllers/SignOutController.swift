//
//  SignOutController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/30/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

class SignOutController:UIViewController{
    
    
    private let SignoutButton: UIButton = {
        let button = Util().buttoncreator(title: "Sign Out")
        button.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignout(){
        print("Signing out user:")
        
        //transition back to first login page possibly, but this makes it too nested look for better solution
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
