//
//  WeatherObject.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 09/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import Foundation

struct WeatherObject : Codable {
    var name : String
    var weather : [Weather]
    var main : Main
}

struct Weather: Codable {
    var description : String
    var icon : String
}

struct Main: Codable {
    var temp : Double
}

