//
//  Constants.swift
//  Rainy
//
//  Created by Ekaterina Nesterova on 27.10.2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

struct URL {
  
  static let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
  static let trafficURL = "http://www.mapquestapi.com/traffic/v2/incidents"
  
}

struct paramKeys {
  
  static let latitude = "lat"
  static let longtitude = "lon"
  static let addId = "APPID"
  static let units = "units"
  
}

struct paramValues {
  
  static let metric = "metric"
  
}

struct jsonTags {
  
  static let weather = "weather"
  static let temperature = "temp"
  static let icon = "icon"
  static let jsonMain = "main"
  static let humidity = "humidity"
  static let pressure = "pressure"
  static let wind = "wind"
  static let speed = "speed"
  static let name = "name"
  static let jsonDescription = "description"
  
}
