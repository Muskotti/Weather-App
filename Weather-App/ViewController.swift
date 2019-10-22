//
//  ViewController.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 08/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var currentTemp : String?
    
    var geoCoder = CLGeocoder()
    var location : CLLocation?
    
    var weather : WeatherFetch?
    
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var WeatherImage: UIImageView!
    @IBOutlet weak var WeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLocation(loc : CLLocationCoordinate2D, place : CLPlacemark) {
        self.LocationLabel.text = place.subAdministrativeArea
        self.weather = WeatherFetch(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&APPID=63dba0881a9c7a2ab8dd3666fe61c42c&units=metric", classView: self)
    }
    
    func changeText(current: Double) {
        self.currentTemp = "\(current) C"
        self.WeatherLabel.text = self.currentTemp
    }
    
    func changeImage(img: Data) {
        self.WeatherImage.image = UIImage(data: img)
    }
}

