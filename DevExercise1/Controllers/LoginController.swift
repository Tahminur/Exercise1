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
    
    
    //MARK: -Layout
    var usernameText:UITextField = {
        let tf = Util().textField(withPlaceolder: "Enter Username")
        return tf
    }()
    private lazy var usernameContainerView:UIView = {
        let view = Util().inputContainerView(textField: usernameText)
        return view
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
        view.addSubview(usernameText)
        view.addSubview(passwordContainerView)
    }
    
}

