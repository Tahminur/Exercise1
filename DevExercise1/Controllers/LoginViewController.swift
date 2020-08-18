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
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        return button
    }()

    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)

        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
//have to fix this so that it can allow multipe attempts to login, currently only allows one
    @objc func handleLogin() {
        guard let username = usernameField.text else { return }
        guard let password = passwordField.text else { return }
        viewModel.login(username: username, password: password){ result in
            switch result {
            case .success:
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                guard let tab = window.rootViewController as? MainTabController else { return }
                
                tab.setupTabs()
                
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    static func create(with viewModel: Login) -> LoginViewController {
        let view = LoginViewController()
        view.viewModel = viewModel
        return view
    }
}
