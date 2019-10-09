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
    
    var geoCoder = CLGeocoder()
    var location : CLLocation?
    var paikka = String()
    
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

    func setLocation(loc : CLLocationCoordinate2D, weather: WeatherClass) {
        self.location = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
        geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
            var place: CLPlacemark!
            place = placemarks?[0]
            self.LocationLabel.text = place.subAdministrativeArea
            weather.fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&APPID=63dba0881a9c7a2ab8dd3666fe61c42c&units=metric")
        })
    }
}

