//
//  Util.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import UIKit

class Util{
    //change this function to remove lat and long since the center at viewpoint actually uses the ags poing coordinate and not the lat or long

    func convertFeatureToCountry(feature: AGSArcGISFeature)->Country{
        let name = feature.attributes["Country_Region"] as! String
        
        var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
        
        if feature.geometry != nil{
            point = feature.geometry as! AGSPoint
        }
        
        let cases = feature.attributes["Confirmed"] as! Int
        
        let country = Country.init(name: name, cases: cases, point: point)
        return country
    }
    
    func textField(withPlaceolder placeHolder: String)-> UITextField{
        let tf = UITextField()
        tf.textColor = .black
        tf.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
        return tf
    }
    
    func buttoncreator(title:String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
        
    }
    
    
    func inputContainerView(textField:UITextField) -> UIView {
        let view = UIView()

        view.addSubview(textField)
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        //below makes the underline.
        let dividerView = UIView()
        dividerView.backgroundColor = .red
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        return view
    }
    
}
