//
//  ViewController.swift
//  EssaisJSON
//
//  Created by stephane verardo on 28/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit
import CoreLocation


struct WeatherDescription: Codable {
    struct Coord: Codable {
        let lon: Int?
        let lat: Int?
    }
    
    struct Weathers: Codable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    struct Main: Codable {
        let temp: Float?
        let pressure: Int?
        let humidity: Int?
        let temp_min: Float?
        let Temp_max: Float?
    }
    
    struct Wind: Codable {
        let speed: Float?
        let deg: Int?
    }

    struct Cloud: Codable {
        let all: Int?
    }
    
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    let coord: [Coord]
    let weathers: [Weathers]
    let base: String?
    let main: [Main]
    let visibilty: Int?
    let wind: [Wind]
    let cloud: [Cloud]
    let dt: Int?
    let sys: [Sys]
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.openweathermap.org/data/2.5/weather?q=Paris&lang=fr&units=metric&APPID=3d0f03af752e96a61f63461350da3438"
        guard let url = URL(string: jsonUrlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "method=getWeather&format=json&lang=fr"
        request.httpBody = body.data(using: .utf8)
        
        
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            do {
                guard let data = data, err == nil else { return }
                guard let res = res as? HTTPURLResponse, res.statusCode == 200 else { return }
                let weather = try JSONDecoder().decode([WeatherDescription].self, from: data)
                
                for weather in weather[0].weathers{
                    print(weather.description!)
                }
                
            }
            catch let jsonErr {
                print("Error Json: ", jsonErr)
            }
            
                
        }.resume()
        }
}
