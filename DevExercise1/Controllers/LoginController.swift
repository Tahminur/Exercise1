//
//  LoginController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/29/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit
import ArcGIS

class LoginController:UIViewController{
    
    
    //MARK: -Variables/Fields
    var usernameText:UITextField = {
        let tf = Util().textField(withPlaceolder: "Enter Username")
        return tf
    }()
    private lazy var usernameContainerView:UIView = {
        let view = Util().inputContainerView(textField: usernameText)
        return view
    }()
     private let LoginButton: UIButton = {
        let button = Util().buttoncreator(title: "Log In")
         button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
         return button
     }()
    
    var passwordText:UITextField = {
        let tf = Util().textField(withPlaceolder: "Enter password")
        return tf
    }()
    private lazy var passwordContainerView:UIView = {
        let view = Util().inputContainerView(textField: passwordText)
        return view
    }()
    
    //MARK: - Configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //view.backgroundColor = .white
    }
    
    func configureUI(){
        view.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [usernameContainerView, passwordContainerView, LoginButton] )
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top:view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right:view.rightAnchor,paddingTop: 96,paddingLeft: 32,paddingRight: 32)
        
    }
    
    
    @objc func handleLogin(){
        guard let username = usernameText.text else {return}
        guard let password = passwordText.text else {return}
        print("Username is \(username) and password is: \(password)")
        
        //handle login logic to arcgis here
        
        //if approved switch to case controller but for now will switch regardless
        user = username
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let switchView = window.rootViewController as? MainTabController else {return}
        
        switchView.authenticateLoggedInUser()
        
        self.dismiss(animated: true, completion: nil)
    }
}

