//
//  ViewController.swift
//  Weather App
//
//  Created by Hassan on 23/05/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainTempLabel: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityTempLabel: UILabel!
    
    
    var cityId :String = "360995"
    let apiKey : String = "937fc2b3043eb23c45eebb8a25b69c2e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeatherTempFromApi()
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCity), name: NSNotification.Name("selectedCity"), object: nil)
        
        /************************ Load GIF image Using Name ********************/
        
        let jeremyGif = UIImage.gifImageWithName("g2")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.3)
        view.addSubview(imageView)
        
    }
    
    @objc func selectedCity(notification : Notification)
    {
        guard let city = notification.userInfo?["city"] as? City else {return}
        cityNameLabel.text = city.cityName
        cityId = city.cityId
        getWeatherTempFromApi()
    }
    
    func getWeatherTempFromApi()
    {
        let parama = ["id" : cityId,
                      "appid" : apiKey]
        
        print(cityId)
        
        
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        
        AF.request(url ,parameters: parama , encoder:  URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value{
                let JSON = result as! NSDictionary
                let main = JSON["main"] as! NSDictionary
                
                
                if  let mainTemp = main["temp"] as? Double
                {
                    let result = "\(Int( mainTemp - 272.15 ))°"
                    self.mainTempLabel.text  = result
                    print("main temp: \(result)")
                }
                
                
                
                if let maxTemp = main["temp_max"] as? Double
                {
                    let result = "\( Int(maxTemp - 272.15) )°"
                    self.maxTempLabel.text = result
                    print("max temp: \(result)")
                }
                
                
                if let minTemp =  main["temp_min"] as? Double
                {
                    let result = "\( Int(minTemp - 272.15) )°"
                    self.minTempLabel.text = result
                    print("min temp: \(result)")
                }
                
                if let humidity = main["humidity"] as? Int
                {
                    self.humidityTempLabel.text = "\(humidity)%"
                }
                
                                
                let wind = JSON["wind"] as! NSDictionary
               
                if let speed = wind["speed"] as? Double {
                    self.windSpeedLabel.text =   "\(round(speed *  1.609344)) km/h"
                    print("speed \(speed)")
                    
                }
                
            }
        }
    }
    
}


extension ViewController
{
    // MARK: this code work for the firs time but dosen't work when pick up city
    func callApi()
    {
        
        let parama = ["id" : cityId,
                      "appid" : apiKey]
        
        print(cityId)
        
        
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        
        
        
        AF.request(url, parameters: parama,encoder:URLEncodedFormParameterEncoder.default).responseDecodable(of: WeatherApi.self) { response in
            
            if let mainTemp = response.value?.main.temp {
                let m = "\(Int( mainTemp - 272.15 ))°"
                self.mainTempLabel.text = m
                print("main temp: \(m)")
            }
            
            if let minTemp = response.value?.main.tempMin {
                
                let  m = "\(Int( minTemp - 272.15 ))°"
                self.minTempLabel.text = m
                print("min temp \(m)")
            }
            
            if let maxTemp = response.value?.main.tempMax {
                
                let m = "\(Int( maxTemp - 272.15 ))°"
                print("max temp \(m)")
                
                self.maxTempLabel.text = m
                
            }
            
            if let windSpeed = response.value?.wind.speed
            {
                
                self.windSpeedLabel.text = "\(round(windSpeed *  1.609344)) km/h"
                
            }
            print(response.value?.main.humidity)
            self.humidityTempLabel.text = "\(response.value?.main.humidity ?? 0)%"
            
            
        }
    }
    
}


