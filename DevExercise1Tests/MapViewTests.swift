//
//  MapViewTests.swift
//  DevExercise1Tests
//
//  Created by Tahminur Rahman on 7/24/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import XCTest
import Mockingbird
import ArcGIS
@testable import DevExercise1

class MapViewTests: XCTestCase {
    

    var Model:MapViewModel!
    var Model2:MapViewModel!
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class
        //used for correct urls
        Model = MapViewModel(map: AGSMap(basemap: .darkGrayCanvasVector()), featureURLs: ["https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1",
        "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2"])
        //will be used for errors
        Model2 = MapViewModel(map: AGSMap(basemap: .darkGrayCanvasVector()), featureURLs: ["https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1"])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Model = nil
        super.tearDown()
    }
    
    //test that makes sure that the maps were added
    func testFeaturesWereAdded(){
        XCTAssertEqual(Model.map.operationalLayers.count, 2)
    }

    
    
    
}
