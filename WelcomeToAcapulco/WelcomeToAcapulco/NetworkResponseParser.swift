//
//  NetworkResponseParser.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation

struct NetworkResponseParser: NetworkResponseParserProtocol
{
        
    func parseDataForWeatherForecast(data: Data?) throws -> Forecast?
    {
        guard data != nil else
        {
            throw NetworkManagerProtocolErrors.JsonCouldntBeParsed
        }
        
        do
        {
            let object = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [AnyHashable : Any]
            
            let forecast = Forecast()
            
            let city = object?["city"] as? [AnyHashable : Any]
            let cityId = city?["id"]
            
            let dateFormatter = dateFormatterToBeUsed()
            
            if let list = object?["list"] as? Array<[AnyHashable : Any]>
            {
                for (_, record) in list.enumerated()
                {
                    let wind = record["wind"] as? [String : Any]
                    let main = record["main"] as? [String : Any]
                    let weatherCondition = record["weather"] as? [[String : Any]]

                    let timeString = record["dt_txt"] as? String
                    var date: Date? = nil
                    
                    if (timeString != nil)
                    {
                        date = dateFormatter.date(from: timeString!)
                    }
                                        
                    let weather = Weather(cityIdentifier: cityId as? Int,
                                          weatherIdentifier: weatherCondition?.first?["id"] as? Int,
                                          weatherDescription: weatherCondition?.first?["description"] as? String,
                                          weatherIcon: weatherCondition?.first?["icon"] as? String,
                                          windSpeed: wind?["speed"] as? Double,
                                          windDeg: wind?["deg"] as? Double,
                                          temperatureFahrenheit: main?["temp"] as? Int,
                                          humidity: main?["humidity"] as? Int,
                                          time: date)

                    forecast.arrayOfWeather.append(weather)
                }
            }
            
            return forecast
        }
        catch
        {
            throw NetworkManagerProtocolErrors.JsonCouldntBeParsed
        }
    }
    
    func dateFormatterToBeUsed()->DateFormatter
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter
    }
}
