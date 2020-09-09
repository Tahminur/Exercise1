//
//  MapViewController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/7/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import ArcGIS
import UIKit

class MapViewController: UIViewController {

    var viewModel: MapViewModel!
    var mapView: AGSMapView = AGSMapView()
    var map: AGSMap!
    var offlineMap: AGSMap?
    var mapper: CalloutMapper!
    //vars below to be moved to local later on
    var parameters: AGSGenerateOfflineMapParameters?
    var offlineMapTask: AGSOfflineMapTask?
    var generateOfflineMapJob: AGSGenerateOfflineMapJob?

    private weak var activeSelectionQuery: AGSCancelable?
    // MARK: - View setup
    static func create(with viewModel: MapViewModel, mapper: CalloutMapper) -> MapViewController {
        let view = MapViewController()
        view.viewModel = viewModel
        let map = AGSMap(basemap: .darkGrayCanvasVector())
        view.map = map
        view.mapper = mapper
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        configureUI()
        setupDelegates()
        self.mapView.map = self.map
        self.viewModel.licenseMap { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMap()
    }

    func setViewpoint() {
        mapView.setViewpoint(AGSViewpoint(center: SharedPoint.shared.point, scale: 30000000))
    }
    // MARK: - Refreshing Map
    func refreshMap() {
        self.map = nil
        self.map = AGSMap(basemap: .darkGrayCanvasVector())
        self.mapView.map = self.map
        self.viewModel.retrieveFeatureLayers { layers in
            for layer in layers {
                self.mapView.map?.operationalLayers.add(layer)
            }
        }
        self.setViewpoint()
    }
    @objc func refreshMapButtonPress(_ sender: Any) {
        self.map = nil
        self.offlineMapTask = nil
        self.map = AGSMap(basemap: .darkGrayCanvasVector())
        self.mapView.map = self.map
        self.viewModel.retrieveFeatureLayers { layers in
            for layer in layers {
                self.mapView.map?.operationalLayers.add(layer)
            }
            self.generateOfflineMapActions()
        }
        self.setViewpoint()

    }
    func configureUI() {
        view.addSubview(mapView)
        self.mapView.pin(to: view)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshMapButtonPress(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}

extension MapViewController: AGSGeoViewTouchDelegate {

    func setupDelegates() {
        mapView.touchDelegate = self
    }
//retrieve the individual feature associated with the click, needs to be called twice in this case
    func retrieveFeature(queryParams: AGSQueryParameters, featureLayer: AGSFeatureLayer, completion: @escaping ([AGSArcGISFeature]) -> Void ) {
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
        retrieveFeature(queryParams: queryParams, featureLayer: featureLayer[0]) { feature in
            clickedFeatureDetails.append(contentsOf: feature)
        }
        retrieveFeature(queryParams: queryParams, featureLayer: featureLayer[1]) { features in
            clickedFeatureDetails.append(contentsOf: features)
            do {
                let callout = try self.mapper.mapToCallout(feature: clickedFeatureDetails)
                    if self.mapView.callout.isHidden {
                        self.mapView.callout.borderWidth = 1
                        self.mapView.callout.title = callout.title
                        self.mapView.callout.detail = callout.detail
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
/*extension MapViewController: OnClickDelegate{
    func onClick(point: AGSPoint) {
        mapView.setViewpoint(AGSViewpoint(center: point, scale: 30000000))
    }
}*/
extension MapViewController {
    //offline map stuff
    func getNewOfflineMapDirectoryURL() -> URL {
        //get suitable directory
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        //create name
        let formattedDate = ISO8601DateFormatter().string(from: Date())

        return documentDirectoryURL.appendingPathComponent("\(formattedDate)")
    }

    func createFrameForOfflineMode() -> AGSEnvelope {
        //change this envelope to fit the required scope
        /*let toleranceInPoints: Double = 500
        let toleranceInMapUnits = toleranceInPoints * mapView.unitsPerPoint
        let envelope = AGSEnvelope(xMin: SharedPoint.shared.point.x - toleranceInMapUnits,
                                    yMin: SharedPoint.shared.point.y - toleranceInMapUnits,
                                    xMax: SharedPoint.shared.point.x + toleranceInMapUnits,
                                    yMax: SharedPoint.shared.point.y + toleranceInMapUnits,
                                    spatialReference: mapView.map?.spatialReference)*/
        let frame = mapView.convert(view.frame, from: view)
        let minPoint = mapView.screen(toLocation: frame.origin)
        let maxPoint = mapView.screen(toLocation: CGPoint(x: frame.maxX, y: frame.maxY))
        let envelope = AGSEnvelope(min: minPoint, max: maxPoint)
        return envelope
    }

    func takeMapOffline() {

        guard let offlineMapTask = offlineMapTask,
            let parameters = parameters else {
                print("parameters not set")
                return
        }

        let downloadDirectory = getNewOfflineMapDirectoryURL()

        let generateOfflineMapJob = offlineMapTask.generateOfflineMapJob(with: parameters, downloadDirectory: downloadDirectory)
        self.generateOfflineMapJob = generateOfflineMapJob
        //can add job prorgess portrayal here

        //start job
        generateOfflineMapJob.start(statusHandler: nil) { [weak self] (result, error) in
            guard let self = self else {
                print("generateofflinemapjob did not start")
                return
            }

            if let error = error {
                self.presentAlert(message: error.localizedDescription)
            } else if let result = result {
                self.takingMapOfflineSuccessful(with: result)
            }
        }

    }

    func takingMapOfflineSuccessful(with result: AGSGenerateOfflineMapResult) {
        if let layerErrors = result.layerErrors as? [AGSLayer: Error],
            let tableErrors = result.tableErrors as? [AGSFeatureTable: Error],
            !(layerErrors.isEmpty && tableErrors.isEmpty) {
            let errorMessages = layerErrors.map { "\($0.key.name): \($0.value.localizedDescription)" } +
                tableErrors.map { "\($0.key.displayName): \($0.value.localizedDescription)" }

            presentAlert(message: errorMessages.joined(separator: "\n"))

        }
        print("Taken Offline successful")
        self.mapView.map = result.offlineMap
    }

    func generateOfflineMapActions() {
        let areaOfInterest = createFrameForOfflineMode()
        self.offlineMapTask = AGSOfflineMapTask(onlineMap: self.mapView.map!)
        print(self.offlineMapTask?.loadStatus.rawValue)
        offlineMapTask?.defaultGenerateOfflineMapParameters(withAreaOfInterest: areaOfInterest) { [weak self] (parameters: AGSGenerateOfflineMapParameters?, error: Error?) in
            guard let parameters = parameters,
                let self = self else {
                    print("issue with setting parameters in generate offline map actions")
                    return
            }

            if let error = error {
                self.presentAlert(message: error.localizedDescription)
                return
            }
            self.parameters = parameters
            self.takeMapOffline()
        }
    }

}
