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

    func setLocation(loc : CLLocationCoordinate2D) {
        self.location = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
        geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
            var place: CLPlacemark!
            place = placemarks?[0]
            self.LocationLabel.text = place.subAdministrativeArea
            self.fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&APPID=63dba0881a9c7a2ab8dd3666fe61c42c&units=metric")
        })
    }
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        
        let NewUrl : URL? = URL(string: url)
        
        let task = session.dataTask(with: NewUrl!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.main.async(execute: {() in
            do {
                let asd = try JSONDecoder().decode(WeatherObject.self, from: data!)
                self.currentTemp = "\(asd.main.temp) C"
                self.WeatherLabel.text = self.currentTemp
                let url = URL(string: "https://openweathermap.org/img/wn/\(asd.weather[0].icon)@2x.png")!
                self.downloadImage(from: url)
            } catch {
                print("rikki")
            }
        })
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.WeatherImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

