//
//  NetworkManagerProtocol.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import Foundation
import UIKit

enum NetworkManagerProtocolErrors: Error
{
    case CallCouldntStart
    case InvalidResponseType
    case ResponseCodeUnsuccesfull
    case ResponseEmpty
    case JsonCouldntBeParsed
    case ImageCouldntBeCreated

}

protocol NetworkManagerProtocol
{
    static func sharedManager(with requestProvider: NetworkRequestsProviderProtocol, sessionProvider: NetworkSessionProviderProtocol, responseParser: NetworkResponseParserProtocol) -> NetworkManagerProtocol
    
    var requestProvider : NetworkRequestsProviderProtocol? {get set}
    var sessionProvider : NetworkSessionProviderProtocol? {get set}
    var responseParser: NetworkResponseParserProtocol? {get set}

    func callForForecastFor(cityId: Int, completionHandler: @escaping (_ succeeded: Bool, _ error: NetworkManagerProtocolErrors?, _ forecast: Forecast?) -> ()) throws -> URLSessionDataTask?
    func callForConditionImageFor(icon: String, completionHandler: @escaping (_ succeeded: Bool, _ error: NetworkManagerProtocolErrors?, _ image: UIImage?) -> ()) throws -> URLSessionDataTask?}
