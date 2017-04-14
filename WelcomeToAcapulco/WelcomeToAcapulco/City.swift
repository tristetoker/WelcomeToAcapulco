//
//  City.swift
//  WelcomeToAcapulco
//
//  Created by Massimiliano Faustini on 13/04/17.
//  Copyright © 2017 f-max. All rights reserved.
//

import UIKit

class City: NSObject {
    var identifier: Int?
    var name: String?
    
    static func acapulco() -> City
    {
        let city = City()
        city.identifier = 3533462
        city.name = "Acapulco"
        
        return city
    }
}
