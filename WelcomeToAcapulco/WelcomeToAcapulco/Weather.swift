//
//  Weather.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import UIKit

class Weather: NSObject
{
    var cityIdentifier: Int?
    var weatherIdentifier: Int?
    var weatherDescription: String?
    var weatherIcon: String?
    var windSpeed: Double?
    var windDeg: Double?
    var temperatureFahrenheit: Int?
    var humidity: Int?
    var time: Date?
    
    convenience init(cityIdentifier: Int?, weatherIdentifier: Int?, weatherDescription: String?, weatherIcon: String?, windSpeed: Double?, windDeg: Double?, temperatureFahrenheit: Int?, humidity: Int?, time: Date?) {
        self.init()
        self.cityIdentifier = cityIdentifier
        self.weatherIdentifier = weatherIdentifier
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.temperatureFahrenheit = temperatureFahrenheit
        self.humidity = humidity
        self.time = time
    }
    
    var dateString: String? {
        get {
            let formatter = dateFormatterToBeUsedForDate()
            return formatter.string(from: time!)
        }
    }
    
    var hourString: String? {
        get {
            let formatter = hourFormatterToBeUsedForDate()
            return formatter.string(from: time!)
        }
    }
    
    var timeString: String? {
        get {
            let formatter = dateFormatterToBeUsedForDate()
            return formatter.string(from: time!)
        }
    }
    
    var windDirectionString: String? {
        get {
            var directionString = ""
            if windDeg != nil {
                let direction = WindDirection(degrees: windDeg!)
                directionString = direction.rawValue
            }
            return "Wind direction: \(directionString)"
        }
    }
    
    var tempearatureString: String? {
        get {
            if let tempearatureString = temperatureFahrenheit { return "Temperature: \(tempearatureString)% F°" }
            return ""
        }
    }
    
    var windSpeedString: String? {
        get {
            if let windSpeedString = windSpeed { return "Wind speed: \(windSpeedString)" }
            return ""
        }
    }
    
    var humidityString: String? {
        get {
            if let humidity = humidity { return "Humidity: \(humidity)%" }
            return ""
        }
    }
    
    private func dateFormatterToBeUsedForDate()->DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter
    }
    
    private func hourFormatterToBeUsedForDate()->DateFormatter
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter
    }
    
    
}
