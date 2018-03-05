//
//  FirstViewController.swift
//  Rainy
//
//  Created by Kirill Averyanov on 17/10/16.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

struct coords{
  var lat: Double = 0
  var lon: Double = 0
}

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var windLabel: UILabel!
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var imageWeather: UIImageView!

  private var locationManager: CLLocationManager!
  private var currentForecast: WeatherForecast? {
    didSet{
      reloadUI()
    }
  }

  private let photoResources: [String: UIImage] = [
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

  private var myCoords: coords = coords()

  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers

    if(CLLocationManager.authorizationStatus() == .notDetermined){
      locationManager.requestWhenInUseAuthorization()
    }
    if CLLocationManager.locationServicesEnabled(){
      locationManager.startUpdatingLocation()
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
      self?.updateCurrentForecast()
    }
  }

  @IBAction func reloadButtonPressed(_ sender: AnyObject) {
    if(CLLocationManager.authorizationStatus() == .notDetermined){
      locationManager.requestWhenInUseAuthorization()
    }
    if CLLocationManager.locationServicesEnabled(){
      locationManager.startUpdatingLocation()
    }
    updateCurrentForecast()
  }

  internal func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {
    print("error: ", error)
  }

  internal func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
    myCoords.lat = locations[0].coordinate.latitude
    myCoords.lon = locations[0].coordinate.longitude
    locationManager.stopUpdatingLocation()
  }


  private func updateCurrentForecast(){
    let request = Alamofire.request("http://api.openweathermap.org/data/2.5/weather",
                                    method: .get,
                                    parameters: ["lat": myCoords.lat, "lon": myCoords.lon, "APPID": "", "units": "metric"],
                                    encoding: JSONEncoding.default,
                                    headers: nil)
    request.responseJSON { response in
      guard response.result.isSuccess else {
        return
      }
      guard let value = response.result.value else {
        return
      }
      let json = JSON(value)
      self.currentForecast = WeatherForecast(currentWeatherTempurature: round(10 * json["main"]["temp"].doubleValue) / 10,
                                             timeStamp: self.getCurrentTime(),
                                             imageName: json["weather"][0]["icon"].string!,
                                             locationCoordinates: (self.myCoords.lat, self.myCoords.lon),
                                             humidity: json["main"]["humidity"].int,
                                             pressure: json["main"]["pressure"].int,
                                             wind: round(10 * json["wind"]["speed"].doubleValue) / 10,
                                             cityName: json["name"].string,
                                             stateWeather: json["weather"][0]["description"].string)
    }
  }

  private func getTrafficInformation() {
    let request = Alamofire.request("http://www.mapquestapi.com/traffic/v2/incidents",
                                    parameters: ["boundingBox": "\(myCoords.lat),\(myCoords.lon),\(myCoords.lat - 1),\(myCoords.lon - 1)",
                                      "key": ""])
    request.responseJSON{response in
      guard response.result.isSuccess else {
        return
      }
      guard let value = response.result.value else {
        return
      }
      _ = JSON(value)
    }
  }

  private func getCurrentTime() -> String {
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.hour, .minute], from: Date())
    guard let componentsHour = components.hour,
      let componentsMinute = components.minute else {
        fatalError()
    }
    var hour: String = String(describing: componentsHour)
    var minute: String = String(describing: componentsMinute)
    if hour.characters.count == 1 {
      hour = "0" + hour
    }
    if(minute.characters.count == 1) {
      minute = "0" + minute
    }
    let currentTime = "\(hour):\(minute)"
    return currentTime
  }

  private func reloadUI() {
    timeLabel.text = "Updated: \(currentForecast!.timeStamp)"
    if let temp = currentForecast?.currentWeatherTempurature {
      temperatureLabel.text = "\(temp)℃"
    }
    if let city = currentForecast?.cityName {
      cityNameLabel.text = city
    }
    if let wind = currentForecast?.wind{
      windLabel.text = "\(wind)"
    }
    if let state = currentForecast?.stateWeather {
      stateLabel.text = state
    }
    guard let forecast = currentForecast?.imageName else {
      return
    }
    imageWeather.image = photoResources[forecast]
  }
}
