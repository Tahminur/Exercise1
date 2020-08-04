//
//  MapViewController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS

class MapViewController: UIViewController {

    var viewModel: MapViewModel!
    var mapView: AGSMapView = AGSMapView()
    var map: AGSMap!
    var mapper: CalloutMapper!
    private weak var activeSelectionQuery: AGSCancelable?
    private weak var activeSelectionQuery2: AGSCancelable?
    // MARK: - View setup
    static func create(with viewModel: MapViewModel, mapper: CalloutMapper, mapController: MapControllerFactory) -> MapViewController {
        let view = MapViewController()
        view.viewModel = viewModel
        let map = AGSMap(basemap: .darkGrayCanvasVector())
        viewModel.retrieveFeatureLayers {layers in
            for layer in layers {
                map.operationalLayers.add(layer)
            }
        }
        view.map = map
        view.mapper = mapper
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        self.mapView.pin(to: view)
        navigationItem.title = "Map"
        setupDelegates()
        self.mapView.map = self.map
        do {
            try viewModel.licenseMap()
        } catch {
            self.presentAlert(message: "Error with Licensing")
        }
        //below is for the method that uses the mapmanager
        //setupMap()
    }
    /*func setupMap(){
        DispatchQueue.main.async {
            self.view.addSubview(self.mapView)
            self.mapView.pin(to: self.view)
            MapManager.shared.refreshMap(on: self.mapView, then: nil)
        }
    }*/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewpoint()
    }
    func setViewpoint() {
        mapView.setViewpoint(AGSViewpoint(center: Storage.shared.point, scale: 30000000))
    }
}

extension MapViewController: AGSGeoViewTouchDelegate {

    func setupDelegates() {
        mapView.touchDelegate = self
    }
    
    func retrieveFeatures(queryParams:AGSQueryParameters, featureLayer:AGSFeatureLayer, completion: @escaping ([AGSArcGISFeature]) -> Void ){
        activeSelectionQuery = featureLayer.selectFeatures(withQuery: queryParams, mode: .new) { [weak self] (queryResult: AGSFeatureQueryResult?, error: Error?) in
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
                completion(calloutDetails!)
            }
            
        }
    }

    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
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
        let featureLayer = mapView.map?.operationalLayers as! [AGSFeatureLayer]
        //the 0 layer countains the country names for the non null ones, while layer 1 contains the vase number and province states which are more numerous, should make layer 1 a base and add on optional countries
        activeSelectionQuery = featureLayer[1].selectFeatures(withQuery: queryParams, mode: .new) { [weak self] (queryResult: AGSFeatureQueryResult?, error: Error?) in
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

                do {
                    let callout = try self!.mapper.mapToCallout(feature: calloutDetails!)
                        if self!.mapView.callout.isHidden {
                            self!.mapView.callout.borderWidth = 1
                            self!.mapView.callout.title = callout.title
                            self!.mapView.callout.detail = "\(callout.detail) confirmed cases so far!"
                            self!.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                            self!.mapView.callout.isAccessoryButtonHidden = true
                        } else {
                            self?.mapView.callout.dismiss()
                        }
                    } catch {
                        self?.presentAlert(message: "This feature has no state province sadly")
                    }
            }

        }
        
        /*if let activeSelectionQuery = activeSelectionQuery {
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
        //have to parse all 3 layers, but fogure put how to
        //let featureLayer = mapView.map!.operationalLayers[0] as! AGSFeatureLayer
        let featureLayer = mapView.map!.operationalLayers as! [AGSFeatureLayer]
        var clickedFeatureDetails: [AGSArcGISFeature] = []
        for layer in featureLayer{
            retrieveFeatures(queryParams: queryParams, featureLayer: layer){ details in
                print("\(String(describing: details[0].attributes["Confirmed"])): \(String(describing: details[0].attributes["Province_State"])): \(String(describing: details[0].attributes["Country_Region"]))")
                print("")
                clickedFeatureDetails.append(contentsOf: details)
            }
        }
        if clickedFeatureDetails.count == 0{
            print("no features selected \(clickedFeatureDetails.count)")
            return
        }
        do {
        let callout = try self.mapper.mapToCallout(feature: clickedFeatureDetails)
            if self.mapView.callout.isHidden {
                print("presenting callout")
                self.mapView.callout.borderWidth = 1
                self.mapView.callout.title = callout.title
                self.mapView.callout.detail = "\(callout.detail) confirmed cases so far!"
                self.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                self.mapView.callout.isAccessoryButtonHidden = true
            } else {
                self.mapView.callout.dismiss()
            }
        } catch {
            self.presentAlert(message: "This feature has no state province sadly")
        }
        */

    }
}
