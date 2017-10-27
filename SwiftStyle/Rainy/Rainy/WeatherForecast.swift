//
//  WeatherForecast.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class WeatherForecast{
  var currentWeatherTempurature: Double?
  var timeStamp: String
  var imageName: String
  var locationCoordinates: (Double, Double)?
  var humidity: Int?
  var pressure: Int?
  var wind: Double?
  var cityName: String?
  var stateWeather: String?
  
  init(currentWeatherTempurature: Double?,
       timeStamp: String, imageName: String,
       locationCoordinates: (Double, Double)?, humidity: Int?, pressure: Int?,
       wind: Double?, cityName: String?, stateWeather: String?) {
    
    self.currentWeatherTempurature = currentWeatherTempurature
    self.timeStamp = timeStamp
    self.imageName = imageName
    self.locationCoordinates = locationCoordinates
    self.humidity = humidity
    self.pressure = pressure
    self.wind = wind
    self.cityName = cityName
    self.stateWeather = stateWeather
  }
}



