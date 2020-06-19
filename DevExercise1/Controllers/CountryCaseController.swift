//
//  CountryCaseController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 6/18/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS


class CountryCaseController:UIViewController{
    private(set) var countryViewModel: CountryViewModel?
    weak var CountryButton: UIButton!
    let CasesFeatureTable: AGSServiceFeatureTable = {
    let featureServiceURL = URL(string: featureURL)!
        return AGSServiceFeatureTable(url: featureServiceURL)
    }()
    
    
    var countryData: Country? {
        didSet {
            guard let countryData = countryData else { return }
            countryViewModel = CountryViewModel.init(myCountry: countryData)
            DispatchQueue.main.async {
                apiManager.queryFeatureLayer()
                self.updateButtons()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.title = "Cases"
    }
    
    func configureUI(){
        view.backgroundColor = .clear
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 20)
    }
    
    
}

extension CountryCaseController{
    

    
    private func queryFeatureLayer(){

        CasesFeatureTable.load { [weak self] (error) in
            
            guard let self = self else { return }

            if let error = error {
                print("Error loading Corona Cases feature layer: \(error.localizedDescription)")
                return
            }

            let queryParameters = AGSQueryParameters()
            queryParameters.whereClause = "\(String.CountryNameKey) like '%%'"
            queryParameters.returnGeometry = true

            let outFields: AGSQueryFeatureFields = .loadAll
            self.CasesFeatureTable.queryFeatures(with: queryParameters, queryFeatureFields: outFields) { (result, error) in

                if let error = error {
                    print("Error querying the Corona Cases feature layer: \(error.localizedDescription)")
                    return
                }

                guard let result = result, let features = result.featureEnumerator().allObjects as? [AGSArcGISFeature] else {
                    print("Something went wrong casting the results.")
                    return
                }
                //the features returned is a set of AGSArcGISFeatures that each consist of an attribute field that contains the data for each country. Now you have to format this so that it can be used to show the data in the cases field.
                
                print("DEBUG: \(features.count)")
                //possibly use
                
                //update my didset values here
                self.countryData = Util().convertFeatureToCountry(feature: features[0])
            }
        }
    }
    
    //currently just one button to prove concept
    private func updateButtons() {
        guard let countryViewModel = countryViewModel else { return }
        CountryButton = Util().customButton(forCountry: countryViewModel.myCountry)
        print("DEBUG: printing country name:\(countryViewModel.myCountry.name)")
    }
    
}
