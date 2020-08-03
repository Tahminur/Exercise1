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
    private weak var activeSelectionQuery: AGSCancelable?
    // MARK: - View setup
    static func create(with viewModel: MapViewModel, mapController: MapControllerFactory) -> MapViewController {
        let view = MapViewController()
        view.viewModel = viewModel
        let map = AGSMap(basemap: .darkGrayCanvasVector())
        viewModel.retrieveFeatureLayers {layers in
            for layer in layers {
                map.operationalLayers.add(layer)
            }
        }
        view.map = map
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
            //queries the given layer within the map.
            let featureLayer = mapView.map!.operationalLayers[1] as! AGSFeatureLayer

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

                    if self!.mapView.callout.isHidden {
                        self!.mapView.callout.title = "Test title"
                        self!.mapView.callout.detail = "Test Details"
                        self!.mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
                        self!.mapView.callout.isAccessoryButtonHidden = true
                    } else {
                        self?.mapView.callout.dismiss()
                    }

            }

        }
    }
}
