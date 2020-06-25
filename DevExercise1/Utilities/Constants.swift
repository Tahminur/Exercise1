//
//  Constants.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import UIKit



let casesURL:String = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1"

let deathsURL:String = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0"

let countryURL:String = "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2"

let mapURL:String = "https://www.arcgis.com/home/item.html?id=bbb2e4f589ba40d692fab712ae37b9ac"


let countryNameKey:String = "Country_Region"

let mapItemID : String = "bbb2e4f589ba40d692fab712ae37b9ac"


let token = "xmu05IoPJPugKWpzUFsukPhMxiYHal8g3bpgfGgAZ44L7cJXxD3W4QzJf4Jv2FCu5EO3IGkSvUgYn6PxP90eKiTRmtx1AxluK2bAQ4gxGyq7vj2u7jqBwPeFX6XLJQQXMKFV45mcRJz6-IcEhvoHQA.."


let userCredentials : AGSCredential = AGSCredential(token: token, referer: "TahminurRahman")


var selectedPoint:AGSPoint = AGSPoint(x: 133, y: -25, spatialReference: .wgs84())

