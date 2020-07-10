//
//  AlertModel.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/9/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import UIKit

public class AlertModel{
    let title:String
    let message:String
    let action:String
    
    init(title:String, message:String, action:String){
        self.title = title
        self.message = message
        self.action = action
    }
    //below model creates alerts but now have to hold them somewhere
    func createAlert(title:String, message:String, action:String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        return alertController
    }
}
