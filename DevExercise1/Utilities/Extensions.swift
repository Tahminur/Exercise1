//
//  Extensions.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit


public extension UIView{
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}

private var window: UIWindow!


public extension UIAlertController{
    func presentAlert(message: String, title: String? = ""){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        alertController.present(animated: true, completion: nil)
    }
    
    
    
    
    func present(animated: Bool, completion: (() -> Void)?){
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level(rawValue: UIWindow.Level.RawValue(2000.0 + 1))
        
        window.makeKeyAndVisible()
        window.rootViewController?.present(self,animated: animated, completion: completion)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        window = nil
    }
    
}
