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
    var emailText:UITextField = {
        let tf = Util().textField(withPlaceolder: "Enter Email")
        return tf
    }()
    private lazy var emailContainerView:UIView = {
        let view = Util().inputContainerView(textField: emailText)
        return view
    }()
     private let LoginButton: UIButton = {
        let button = Util().buttoncreator(title: "Log In")
         button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
         return button
     }()
    
    var passwordText:UITextField = {
        let tf = Util().textField(withPlaceolder: "Enter password")
        tf.isSecureTextEntry = true
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

        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, LoginButton] )
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top:view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right:view.rightAnchor,paddingTop: 96,paddingLeft: 32,paddingRight: 32)
        
    }
    
    
    @objc func handleLogin(){
        guard let email = emailText.text else {return}
        guard let password = passwordText.text else {return}
        
        AuthServices.handler.logUserIn(email: email, password: password){ (result, error) in
            if let error = error {
                print("DEBUG: Error logging in: \(error.localizedDescription)")
                return
            }
            //if approved switch to case controller but for now will switch regardless
            //user = username
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let switchView = window.rootViewController as? MainTabController else {return}
            switchView.authenticateLoggedInUser()
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

//Two possible ways to implement handling this

//ONE:Firebase authentication. It allows for easy integration with current setup as well as allows for the remember me functionality


//TWO: use arcgis remote resource protocol,arcgis authentication challenge, and the continue with credential function. Will have to also then have to use the AGSCredentialCache handling remember me and clearing out credentialcache
