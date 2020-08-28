//
//  SharedPoint.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 8/28/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

public final class SharedPoint {
    public static var shared = SharedPoint()
    var point: AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())
}
