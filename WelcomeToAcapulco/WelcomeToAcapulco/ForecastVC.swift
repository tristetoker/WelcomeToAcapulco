//
//  ForecastVC.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import UIKit

class ForecastVC: UITableViewController {
    
    private static var reuseIdentifier = "cellForecast"
    
    var city: City?
    var arrayOfWeatherGrouped: [[Weather]]?
    
    var networkManger: NetworkManagerProtocol?
    
    // MARK: - Initialization
    
    func injectDependencies(with city: City, networkManager: NetworkManagerProtocol)
    {
        self.city = city
        self.networkManger = networkManager
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ForecastCell", bundle: nil), forCellReuseIdentifier: ForecastVC.reuseIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
    }
    
    // MARK: - Main tasks

    func refreshData()
    {
        guard city?.identifier != nil, networkManger != nil else { return }
        
        let _ = try? networkManger?.callForForecastFor(cityId: (city?.identifier)!, completionHandler: {
            [weak self]
            (success, error, forecast) in
            self?.refreshControl?.endRefreshing()
            if success && forecast != nil {
                self?.arrayOfWeatherGrouped = forecast?.arrayOfWeatherGrouped
                self?.refreshUI()
            }
        })
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            [weak self]
            in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = arrayOfWeatherGrouped?.count else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = arrayOfWeatherGrouped?[section].count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastVC.reuseIdentifier, for: indexPath) as? ForecastCell else  { assert(false) }
        
        cell.injectDependencies(with: arrayOfWeatherGrouped?[indexPath.section][indexPath.row], networkManager: networkManger)
        cell.stopPreviousTasks()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let title = arrayOfWeatherGrouped?[section].first?.dateString else { return "" }
        return title
    }
    
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        guard let cellForecast = cell as? ForecastCell else { assert(false) }
        
        cellForecast.configureUI()
    }
    
}
