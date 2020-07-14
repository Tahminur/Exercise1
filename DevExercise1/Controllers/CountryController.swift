//
//  CountryController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS
import Network


class CountryController:UIViewController{
    var tableView = UITableView()
    private let refresher = UIRefreshControl()
    //below for newtwork connection
    private let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    
    var viewModel:CountryCasesViewModel = CountryCasesViewModel(repository: CountryDataRepository(remoteDataSource: CountryCasesRemoteDataSource(), storage: CountryStorage.shared))
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFromDataSource(forceRefresh: false){
            print("# of countries to appear\(self.viewModel.Countries.count)")
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.fetchFromDataSource(forceRefresh: true){
            print("# of countries to appear \(self.viewModel.Countries.count)")
            self.tableView.reloadData()
        }
        navigationItem.title = "New Cases"
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
        viewModel.fetchFromDataSource(forceRefresh: true){
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
        self.InternetConnectionCheck()
    }
    
    func InternetConnectionCheck() {
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                self.presentAlert(message: "No Internet Connection")
            }
        }
        monitor.start(queue: DispatchQueue.main)
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}



//MARK: - TableView
extension CountryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.Countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        
        cell.set(country: viewModel.Countries[indexPath.row].country)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let clickedCell = tableView.cellForRow(at: indexPath!)! as! CountryCell
        //have to figure out how to pass this to the new map
        CountryStorage.shared.point = clickedCell.point
        
        self.tabBarController?.selectedIndex = 1
        
    }
}
