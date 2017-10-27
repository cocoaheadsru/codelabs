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
    
    private enum classConstants {
        static let trafficUrl = "http://www.mapquestapi.com/traffic/v2/incidents"
    }
    
    private var myCoords: coords = coords()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.updateForecast()
        })
    }

    @IBAction func reloadButtonPressed(_ sender: AnyObject) {
        updateForecast()
    }
    
    private func updateForecast() {
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
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lat = locations.first?.coordinate.latitude, let lon = locations.first?.coordinate.longitude else {
            return
        }
        self.myCoords.lat = lat
        self.myCoords.lon = lon
        locationManager.stopUpdatingLocation()
    }


    private func updateCurrentForecast(){
      Alamofire.request(constants.weatherUrl, method: .get, parameters: ["lat":myCoords.lat,"lon": myCoords.lon,"APPID": "","units":"metric"],encoding: JSONEncoding.default,headers: nil).responseJSON{response in
                guard response.result.isSuccess else{
                    return
                }
                let json = JSON(response.result.value!)
                self.currentForecast = WeatherForecast(currentWeatherTempurature: round(10 * json["main"]["temp"].doubleValue) / 10,
                                                               timeStamp: self.getCurrentTime(),
                                                               imageName: json["weather"][0]["icon"].string!,
                                                               locationCoordinates: (self.myCoords.lat, self.myCoords.lon),
                                                               humidity: json["main"]["humidity"].int,
                                                               pressure: json["main"]["pressure"].int,
                                                               wind: round(10 * json["wind"]["speed"].doubleValue) / 10, cityName: json["name"].string,
                                                               stateWeather: json["weather"][0]["description"].string)
        }
    }
    
    private func getTrafficInformation(){
        Alamofire.request(classConstants.trafficUrl,
                          parameters: ["boundingBox": "\(myCoords.lat),\(myCoords.lon),\(myCoords.lat - 1),\(myCoords.lon - 1)",
                                       "key": ""])
            .responseJSON{response in
                guard response.result.isSuccess else{
                    return
                }
                _ = JSON(response.result.value!)
        }
    }
    
    private func getCurrentTime() -> String{
        let date = NSDate()
        let calendar = NSCalendar.current
        var currentTime: String
        let components = calendar.dateComponents([.hour, .minute], from: date as Date!)
        var hour: String = String(describing: components.hour!)
        var minute: String = String(describing: components.minute!)
        if hour.characters.count == 1{
            hour = "0" + hour
        }
        if(minute.characters.count == 1){
            minute = "0" + minute
        }
        currentTime = "\(hour):\(minute)"
        return currentTime
    }
    
    private func reloadUI(){
        timeLabel.text = "Updated: \(currentForecast!.timeStamp)"
        guard let forecast = currentForecast else { return }
        temperatureLabel.text = String(describing: forecast.currentWeatherTempurature)
        cityNameLabel.text = forecast.cityName
        windLabel.text = String(describing: forecast.wind)
        stateLabel.text = forecast.stateWeather
        imageWeather.image = photoResources[forecast.imageName]
    }
}


