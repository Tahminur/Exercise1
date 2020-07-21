//
//  MapViewController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS





class MapViewController:UIViewController{
    //TODO: make sure map is also refreshed upon pull to refresh!!!
    var viewModel: MapViewModel = MapViewModel(map: AGSMap(basemap: .darkGrayCanvasVector()), featureURLs: [ "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/2",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1",
    "https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/0"])
    var mapView:AGSMapView = AGSMapView()
    
    //Used for handling callouts
    private weak var activeSelectionQuery: AGSCancelable?
    
    //MARK:-View setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        navigationItem.title = "New Map"
        setupDelegates()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.setViewpoint(AGSViewpoint(center: CountryStorage.shared.point, scale: 30000000))
        //try self.viewModel.refreshMap(isRefresh: true)
    }
    
    func setupMapView(){
        view.addSubview(mapView)
        mapView.pin(to: view)
        do{
            try viewModel.authenticateMap()
        } catch{
            self.presentAlert(message: "Authentication Failed")
        }
        mapView.map = viewModel.map
    }
}


//MARK:- Callouts
extension MapViewController: AGSGeoViewTouchDelegate{

    func setupDelegates(){
        self.mapView.touchDelegate = self
    }
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint){
        if let activeSelectionQuery = activeSelectionQuery {
            activeSelectionQuery.cancel()
        }
        //builds tap tolerance
        let toleranceInPoints: Double = 12
        let toleranceInMapUnits = toleranceInPoints * mapView.unitsPerPoint
        let envelope = AGSEnvelope(xMin: mapPoint.x - toleranceInMapUnits,
                                   yMin: mapPoint.y - toleranceInMapUnits,
                                   xMax: mapPoint.x + toleranceInMapUnits,
                                   yMax: mapPoint.y + toleranceInMapUnits,
                                   spatialReference: mapView.map?.spatialReference)
        
        let queryParams = AGSQueryParameters()
        queryParams.geometry = envelope
        //queries the given layer within the map. 
        let featureLayer = viewModel.map.operationalLayers[1] as! AGSFeatureLayer
        
        activeSelectionQuery = featureLayer.selectFeatures(withQuery: queryParams, mode: .new) { [weak self] (queryResult:AGSFeatureQueryResult?, error: Error?) in
            if let error = error {
                self?.presentAlert(message: error.localizedDescription)
            }
            self!.mapView.callout.dismiss()
            //do something here to have the callout
            if let result = queryResult {
                //print("\(result.featureEnumerator().allObjects.count) feature(s) selected")
                let calloutDetails = result.featureEnumerator().allObjects as? [AGSArcGISFeature]
                //makes sure that there is a feature associated with the callOutDetails else exits the function
                if calloutDetails!.count == 0 {
                    
                    return
                }
                //for some reason some of the province states return null so have a catch statement for those errors, for now displays an alert, maybe can replace it with something else
                do{
                    let callout = try CalloutMapper().mapToCallout(feature: calloutDetails!)
                    if self!.mapView.callout.isHidden {
                        self!.mapView.callout.title = callout.title
                        self!.mapView.callout.detail = "\(callout.detail) confirmed cases so far!"
                        self!.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                        self!.mapView.callout.isAccessoryButtonHidden = true
                    } else {
                        self?.mapView.callout.dismiss()
                    }
                } catch{
                    self?.presentAlert(message: "This feature has no state province sadly")
                }
            }
        
        }
        
    }
    
}

