//
//  ForecastCell.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelCondition: UILabel!
    @IBOutlet var labelTemperature: UILabel!
    @IBOutlet var labelHumidity: UILabel!
    @IBOutlet var labelWindSpeed: UILabel!
    @IBOutlet var labelWindDirection: UILabel!
    
    @IBOutlet var imageViewCondition: UIImageView!
    
    var networkManager: NetworkManagerProtocol?
    var dataTask: URLSessionDataTask?
    var weather: Weather?
    
    func stopPreviousTasks() {
        dataTask?.cancel()
    }

    func injectDependencies(with weather: Weather?, networkManager: NetworkManagerProtocol?) {
        self.weather = weather
        self.networkManager = networkManager
    }
    
    func configureUI() {
        resetUI()
        
        if let hour = weather?.hourString { labelTime.text = hour }
        if let condition = weather?.weatherDescription { labelCondition.text = condition }
        if let temperature = weather?.temperatureFahrenheit { labelTemperature.text = "Temperature: \(temperature) F°" }
        if let windSpeed = weather?.windSpeedString { labelWindSpeed.text = windSpeed }
        if let windDirectionString = weather?.windDirectionString { labelWindDirection.text = windDirectionString }
        if let humidityString = weather?.humidityString { labelHumidity.text = humidityString }

        loadImage()
    }
    
    func resetUI() {
        imageViewCondition.image = nil
        labelTime.text = "Time:"
        labelCondition.text = "-"
        labelTemperature.text = "-"
        labelWindSpeed.text = "Wind speed: -"
        labelWindDirection.text = "Wind direction: -"
        labelHumidity.text = "Humidity: -"
    }
    
    func loadImage() {
        guard let icon = weather?.weatherIcon else { return }

        try? dataTask = networkManager?.callForConditionImageFor(icon: icon, completionHandler: { (success, error, image) in
            if success && image != nil {
                DispatchQueue.main.async {
                    [weak self]
                    in
                    self?.imageViewCondition?.image = image
                }
            }
        })
    }
    
   
}
