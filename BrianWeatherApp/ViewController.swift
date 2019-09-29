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

    var imageName: [String] = [
        String("clear-day"),
        String("clear-night"),
        String("cloudy"),
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
        
        if let url = NSURL(string: "https://api.forecast.io/forecast/05f17d12e654801312d18552ec8b2704/42.2132,-88.2477") {
            if let data = NSData(contentsOf: url as URL){
                do {
                    let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    
                    let newDict = parsed
                    
                    let icon = newDict["currently"]!["icon"] as! String
                    var temp = newDict["currently"]!["temperature"] as! Double
                    temp = round(temp)
                    var humid = newDict["currently"]!["humidity"] as! Double
                    humid = round(humid * 100)
                    var aTemp = newDict["currently"]!["apparentTemperature"] as! Double
                    aTemp = round(aTemp)

                    if imageName.contains(icon) {
                        let imageToDisplay = ("\(icon).png")
                        imageView.image = UIImage(named: imageToDisplay)
                    }else{
                        imageView.image = UIImage(named: "default.png")
                    }
                    
                    self.currentHumidity.text = "\(String(describing: humid)) %"
                    self.currentTemp.text = "\(temp)\u{00B0}F"
                    self.currentSummary.text = "\(newDict["currently"]!["summary"]!!)"
                    self.currentApparentTemp.text = "Feels like \(aTemp)\u{00B0}F"
                }
                catch let error as NSError {
                    print("A JSON parsithng error occurred, here are the details:\n \(error)")
                }
            }
        }
    }
}

