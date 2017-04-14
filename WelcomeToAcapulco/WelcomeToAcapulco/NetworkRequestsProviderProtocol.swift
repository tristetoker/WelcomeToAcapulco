//
//  NetworkRequestsProviderProtocol.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation

protocol NetworkRequestsProviderProtocol
{
    func requestForWeatherForecastFor(cityId: Int) throws -> URLRequest
    func requestForConditionImageFor(icon: String) throws -> URLRequest
}
