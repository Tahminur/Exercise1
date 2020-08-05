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

    func retrieveFeatures(queryParams: AGSQueryParameters, featureLayer: AGSFeatureLayer, completion: @escaping ([AGSArcGISFeature]) -> Void ) {
        activeSelectionQuery = featureLayer.selectFeatures(withQuery: queryParams, mode: .new) { [weak self] (queryResult: AGSFeatureQueryResult?, error: Error?) in
            if let error = error {
                self?.presentAlert(message: error.localizedDescription)
            }
            self!.mapView.callout.dismiss()
            //do something here to have the callout
            if let result = queryResult {
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
        let featureLayer = mapView.map!.operationalLayers as! [AGSFeatureLayer]
        var clickedFeatureDetails: [AGSArcGISFeature] = []
        //have to use the retrieveFeatures twice once for each of the featureLayers we are concerned with
        retrieveFeatures(queryParams: queryParams, featureLayer: featureLayer[0]) { feature in
            clickedFeatureDetails.append(contentsOf: feature)
        }
        retrieveFeatures(queryParams: queryParams, featureLayer: featureLayer[1]) { features in
            clickedFeatureDetails.append(contentsOf: features)
            do {
                let callout = try self.mapper.mapToCallout(feature: clickedFeatureDetails)
                    if self.mapView.callout.isHidden {
                        self.mapView.callout.borderWidth = 1
                        self.mapView.callout.title = callout.title
                        self.mapView.callout.detail = "\(callout.detail) confirmed cases so far!"
                        self.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                        self.mapView.callout.isAccessoryButtonHidden = true
                    } else {
                        self.mapView.callout.dismiss()
                    }
                } catch {
                    self.presentAlert(message: "This feature has no data sadly")
                }
            }
            if clickedFeatureDetails.count == 0 {
                return
            }
        }
}
