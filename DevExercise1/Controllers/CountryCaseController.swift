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
    var tableView = UITableView()
    private let refresher = UIRefreshControl()
    let CasesFeatureTable: AGSServiceFeatureTable = {
    let featureServiceURL = URL(string: featureURL)!
        return AGSServiceFeatureTable(url: featureServiceURL)
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //have it perform asynchronously so update tableview can be called
        apiManager.queryFeatureLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.reloadData()
        }
        configureTableView()
        navigationItem.title = "Cases"
    }
    
    //MARK: -Layout
    
    func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 50
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.pin(to: view)
        tableView.addSubview(refresher)
        refresher.addTarget(self, action: #selector(refreshCountryData(_:)), for: .valueChanged)
    }
    
    @objc func refreshCountryData(_ sender: Any){
        print("Refreshing data")
        apiManager.queryFeatureLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CountryCaseController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataRetrieved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        cell.countryButton.tag = indexPath.row
        
        let country = Util().convertFeatureToCountry(feature: DataRetrieved[indexPath.row])
        
        cell.set(country: country)
        
        return cell
    }
    
}
