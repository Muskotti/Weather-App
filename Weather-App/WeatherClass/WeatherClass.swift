//
//  WeatherClass.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 09/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import Foundation

class WeatherClass {
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        
        let NewUrl : URL? = URL(string: url)
        
        let task = session.dataTask(with: NewUrl!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            print(resstr!)
        })
    }
}
