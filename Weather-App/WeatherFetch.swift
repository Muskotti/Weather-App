//
//  WeatherFetch.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 22/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import UIKit

class WeatherFetch {
    
    var castImg: [UIImage]
    var weatherData: [WeatherObject]
    var viewC : ViewController?
    var viewF : ForecastViewController?
    
    
    init (url : String, classView: ViewController){
        castImg = []
        weatherData = []
        viewC = classView
        self.fetchUrl(url: url)
    }
    
    init (url : String, classView: ForecastViewController) {
        castImg = []
        weatherData = []
        viewF = classView
        self.fetchUrl(url: url)
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
                if(self.viewC != nil) {
                    self.viewC?.setSearch(true)
                    let asd = try JSONDecoder().decode(WeatherObject.self, from: data!)
                    self.viewC?.changeText(current: asd.main.temp)
                    let url = URL(string: "https://openweathermap.org/img/wn/\(asd.weather[0].icon)@2x.png")!
                    self.downloadImage(from: url)
                } else if (self.viewF != nil) {
                    let asd = try JSONDecoder().decode(ForecastInfoModel.self, from: data!)
                    self.viewF?.setText(asd.list)
                    for qwe in asd.list {
                        let url = URL(string: "https://openweathermap.org/img/wn/\(qwe.weather[0].icon)@2x.png")!
                        self.viewF?.images = []
                        self.downloadImage(from: url)
                    }
                }
            } catch {
                print("rikki")
            }
        })
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if(self.viewC != nil){
                    self.viewC?.changeImage(img: data)
                    self.viewC?.setSearch(false)
                } else if (self.viewF != nil) {
                    self.viewF?.setImages(img: data)
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
