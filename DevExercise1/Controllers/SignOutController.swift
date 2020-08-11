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

    var viewModel: SignOut!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }

    static func create(with viewModel: SignOut) -> SignOutController {
        let view = SignOutController()
        view.viewModel = viewModel
        return view
    }
}
