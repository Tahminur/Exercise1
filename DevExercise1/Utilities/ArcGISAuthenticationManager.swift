//
//  ArcGISAuthenticationManager.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

class ArcGISAuthenticationManager: NSObject{
    static let shared = ArcGISAuthenticationManager()
    var portal: AGSPortal!
}
