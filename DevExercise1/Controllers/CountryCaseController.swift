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

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.reloadData()
        }*/
        
        navigationItem.title = "Cases"
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        API.sharedInstance.queryFeatureLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
}
//MARK: - TableView
extension CountryCaseController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetching row of \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return API.sharedInstance.DataRetrieved.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        
        let country = Util().convertFeatureToCountry(feature: API.sharedInstance.DataRetrieved[indexPath.row])
        
        cell.set(country: country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let clickedCell = tableView.cellForRow(at: indexPath!)! as! CountryCell
        
        API.sharedInstance.selectedPoint = clickedCell.point
        
        self.tabBarController?.selectedIndex = 1
        
    }
}
