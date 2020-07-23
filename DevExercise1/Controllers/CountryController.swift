//
//  CountryController.swift
//  DevExercise1
//
//  Created by Tahminur Rahman on 7/8/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import UIKit
import ArcGIS
import Reachability


class CountryController:UIViewController{
    var tableView = UITableView()
    private let refresher = UIRefreshControl()
    
    
    var viewModel:CountryCasesViewModel = CountryCasesViewModel(repository: CountryDataRepository(remoteDataSource: CountryCasesRemoteDataSource()))
    
    
    func setupCountries(possibleMsg:String?){      
        if possibleMsg == nil{
            self.tableView.reloadData()
        }
        else{
            self.tableView.reloadData()
            self.presentAlert(message: possibleMsg!)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if InternetConnection.shared.status != nil{
            self.presentAlert(message: InternetConnection.shared.status!)
        }else{
            viewModel.fetchFromDataSource(forceRefresh: false,completion: setupCountries(possibleMsg:))
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        if InternetConnection.shared.status != nil{
            self.presentAlert(message: InternetConnection.shared.status!)
        }else{
            viewModel.fetchFromDataSource(forceRefresh: true,completion: setupCountries(possibleMsg:))
        }
        navigationItem.title = "Cases"
    }
    //MARK: -Layout
    
    @objc func refreshCountryData(_ sender: Any){
        if InternetConnection.shared.status != nil{
            self.presentAlert(message: InternetConnection.shared.status!)
            self.refresher.endRefreshing()
        }else{
            viewModel.fetchFromDataSource(forceRefresh: true,completion: setupCountriesRefresh(possibleMsg:))
        }
        
    }
    
    func setupCountriesRefresh(possibleMsg:String?){
        if possibleMsg == nil{
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
        else{
            self.presentAlert(message: possibleMsg!)
            self.refresher.endRefreshing()
            
            
        }
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}



//MARK: - TableView
extension CountryController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        Storage.shared.point = clickedCell.point
        
        
        self.tabBarController?.selectedIndex = 1
        
    }
}
