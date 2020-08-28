//
//  SignOutController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/11/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

class SignOutController: UIViewController {

    var viewModel: SignOutUseCase!
    lazy var appDIContainer: AppDIContainer = {
        return (UIApplication.shared.delegate as! AppDelegate).appDIContainer
    }()

    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return button
    }()

    @objc func handleSignOut() {
        viewModel.signOut { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let loginController = self.appDIContainer.userContainer.makeLoginViewController()
                    let nav = UINavigationController(rootViewController: loginController)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
                    self.tabBarController?.selectedIndex = 0
                }
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        navigationItem.title = "Sign Out"
        view.addSubview(signOutButton)
        signOutButton.anchor(top: view.safeAreaLayoutGuide.centerYAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }

    static func create(with viewModel: SignOutUseCase) -> SignOutController {
        let view = SignOutController()
        view.viewModel = viewModel
        return view
    }
}
