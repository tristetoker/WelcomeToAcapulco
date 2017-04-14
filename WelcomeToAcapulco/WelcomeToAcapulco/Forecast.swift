//
//  Forecast.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import UIKit

class Forecast: NSObject
{
    // MARK: - Stored properties
    
    var arrayOfWeather = [Weather]()
    
    // MARK: - Computed properties
    
    var arrayOfWeatherGrouped: [[Weather]]?
    {
        var result = [[Weather]]()
        var dict = [Date : [Weather]]()
        
        // create a dictionary with dates as keys (ignoring time)
        for (_, weather) in (arrayOfWeather.enumerated())
        {
            guard let weatherTime = weather.time else { continue }
            
            // Take just the day to be used as dict key
            let setOfDayComponents: Set<Calendar.Component> = [.year, .month, .day]
            let components = Calendar.current.dateComponents(setOfDayComponents, from: weatherTime)
            
            guard let justDay = Calendar.current.date(from: components) else { continue }
            
            // Add key if that day is not present
            if (dict[justDay] == nil)
            {
                dict[justDay] = [Weather]()
            }
            // add weather and keep sorted by time (inner result array)
            dict[justDay]?.append(weather)
            dict[justDay]?.sort(by: {$0.time!<$1.time!})
        }
        
        // build result from dictionary, sort by date (outer result array)
        result = dict.map({$1}).sorted { (lv, rv) -> Bool in
            (lv.first?.time)! < (rv.first?.time)!
        }
        
        return result
    }
    
}
