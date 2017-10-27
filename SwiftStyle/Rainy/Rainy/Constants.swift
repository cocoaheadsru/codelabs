//
//  Constants.swift
//  Rainy
//
//  Created by di on 27.10.2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import UIKit

struct Resources {
  static let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
  static let trafficURL = "http://www.mapquestapi.com/traffic/v2/incidents"
}

let photoResources: [String: UIImage] = [
  "01d":#imageLiteral(resourceName: "sunny"),
  "01n":#imageLiteral(resourceName: "moon"),
  "02d":#imageLiteral(resourceName: "sunny_clouds"),
  "02n":#imageLiteral(resourceName: "moodCloud"),
  "03d":#imageLiteral(resourceName: "clouds"),
  "03n":#imageLiteral(resourceName: "clouds"),
  "04d":#imageLiteral(resourceName: "clouds"),
  "04n":#imageLiteral(resourceName: "clouds"),
  "09d":#imageLiteral(resourceName: "cloud_rain"),
  "09n":#imageLiteral(resourceName: "cloud_rain"),
  "10d":#imageLiteral(resourceName: "sunCloudRain"),
  "10n":#imageLiteral(resourceName: "moonrain"),
  "11d":#imageLiteral(resourceName: "storm"),
  "11n":#imageLiteral(resourceName: "storm"),
  "13d":#imageLiteral(resourceName: "CloudSnow"),
  "13n":#imageLiteral(resourceName: "CloudSnow"),
  "50d":#imageLiteral(resourceName: "fog"),
  "50n":#imageLiteral(resourceName: "fog")
]
