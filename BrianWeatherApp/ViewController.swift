//
//  ViewController.swift
//  BrianWeatherApp
//
//  Created by Brian Wawczak on 9/28/19.
//  Copyright © 2019 Brian Wawczak. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemp: UILabel!
    
    @IBOutlet weak var currentSummary: UILabel!
    
    @IBOutlet weak var currentHumidity: UILabel!
    
    @IBOutlet weak var currentApparentTemp: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var iconImage: [UIImage] = [
        UIImage(named: "clear-day.png")!,
        UIImage(named: "clear-night.png")!,
        UIImage(named: "cloudy.png")!,
        UIImage(named: "default.png")!,
        UIImage(named: "fog.png")!,
        UIImage(named: "partly-cloudy-day.png")!,
        UIImage(named: "partly-cloudy-night.png")!,
        UIImage(named: "rain.png")!,
        UIImage(named: "snow.png")!,
        UIImage(named: "sleet.png")!,
        UIImage(named: "wind.png")!
    ]
    
    var imageName: [String] = [
        String("clear-day"),
        String("clear-night"),
        String("cloudy.png"),
        String("default"),
        String("fog"),
        String("partly-cloudy-day"),
        String("partly-cloudy-night"),
        String("rain"),
        String("snow"),
        String("sleet"),
        String("wind"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if let url = NSURL(string: "https://api.forecast.io/forecast/05f17d12e654801312d18552ec8b2704/37.7833,122.4167") {
            if let data = NSData(contentsOf: url as URL){
                do {
                    let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    
                    let newDict = parsed
                    
                    let icon = newDict["currently"]!["icon"] as! String
                    
                    var temp = newDict["currently"]!["temperature"] as! Double
                    temp = round(temp)
                    
                    var humid = newDict["currently"]!["humidity"] as! Double
                    humid = humid * 100
                    
                    var aTemp = newDict["currently"]!["apparentTemperature"] as! Double
                    aTemp = round(aTemp)
                    
                    
                    
                    if imageName.contains(icon) {
                        let imageToDisplay = ("\(icon).png")

                        print(imageToDisplay)
                        print("\(icon) it works")
                    }else{
                        print("didn't work \(icon)")
                    }
                    
                    
//                    self.currentHumidity.text = "\(String(describing: humid)) %"
//                    self.currentTemp.text = "\(temp)F"
//                    self.currentSummary.text = "\(newDict["currently"]!["summary"]!!)"
//                    self.currentApparentTemp.text = "Feels like \(aTemp)F"
                    
                }
                catch let error as NSError {
                    print("A JSON parsithng error occurred, here are the details:\n \(error)")
                }
            }
        }
        
    }
    
}

