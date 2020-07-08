//
//  CountryController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS



class CountryController:UIViewController{
    var tableView = UITableView()
    private let refresher = UIRefreshControl()
    var viewModel:CountryCasesViewModel!
    
    static func create(with viewModel: CountryCasesViewModel) -> CountryController{
        let view = CountryController()
        view.viewModel = viewModel
        
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //need to fix issue of nil beign found in the view model  have to instantiate somewhere TODO figure out where
        viewModel.fetchFromDataSource(forceRefresh: false){
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        }
        
        
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
        //have to figure out how to pass this to the map
        API.sharedInstance.selectedPoint = clickedCell.point
        
        self.tabBarController?.selectedIndex = 1
        
    }
}
