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
    let CasesFeatureTable: AGSServiceFeatureTable = {
    let featureServiceURL = URL(string: featureURL)!
        return AGSServiceFeatureTable(url: featureServiceURL)
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //have it perform asynchronously so update tableview can be called
        apiManager.queryFeatureLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            
            self.tableView.reloadData()
        }
        
        

        configureTableView()
        navigationItem.title = "Cases"
    }
    
    //MARK: -Layout
    
    func configureTableView() {
        view.backgroundColor = .white
        print("Inside country controller there are: \(DataRetrieved.count)")
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 50
        
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        
        tableView.pin(to: view)
    }
    
    func updateTable() {
        let hasNewCells = DataRetrieved.count > 0
        
        if hasNewCells {
            tableView.reloadData()
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
        
        let country = Util().convertFeatureToCountry(feature: DataRetrieved[indexPath.row])
        
        cell.set(country: country)
        
        return cell
    }
    
    
}
