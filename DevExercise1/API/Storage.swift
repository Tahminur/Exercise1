//
//  Storage.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public final class Storage {
    public static var shared = Storage()
    var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
}
