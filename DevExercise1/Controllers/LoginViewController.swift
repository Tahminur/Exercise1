//
//  LoginViewController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    var viewModel: Login!
    // MARK: - UIView Elements
    private let usernameField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()

    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = true
        return tf
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enable Remember Me"
        label.textColor = .white
        return label
    }()

    private let rememberMeSwitch: UISwitch = {
        let button = UISwitch()
        button.thumbTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.onTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(enableRememberMe), for: .valueChanged)
        return button
    }()
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.reset()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRememberedCredentials()
        viewModel.rememberMe = false
    }
    func setRememberedCredentials() {
        usernameField.text = viewModel.username
        passwordField.text = viewModel.password
        if viewModel.username != "" && viewModel.password != "" {
            usernameField.text = viewModel.username
            passwordField.text = viewModel.password
        } else {
            usernameField.text = ""
            passwordField.text = ""
        }
    }

    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        let rememberMe = UIStackView(arrangedSubviews: [rememberMeLabel, rememberMeSwitch])
        rememberMe.axis = .horizontal
        rememberMe.spacing = 20
        rememberMe.distribution = .fillProportionally
        rememberMe.alignment = .center
        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton, rememberMe])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
//have to fix this so that it can allow multipe attempts to login, currently only allows one
    @objc func handleLogin() {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        viewModel.login(username: username, password: password, rememberMe: rememberMeSwitch.isOn) { result in
            switch result {
            case .success:
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                guard let tab = window.rootViewController as? MainTabController else { return }

                tab.setupTabs()

                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }
    @objc func enableRememberMe() {
        if rememberMeSwitch.isOn {
            print("handle remembering here")
        }
        //viewModel.rememberMe = rememberMeSwitch.isOn
    }

    static func create(with viewModel: Login) -> LoginViewController {
        let view = LoginViewController()
        view.viewModel = viewModel
        return view
    }
}
