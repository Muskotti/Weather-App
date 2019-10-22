//
//  ForecastViewController.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 08/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var Image: UIImageView!
    
    var stuff = [String]()
    var weather : WeatherFetch?
    var images : [UIImage] = []
    var subText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(stuff[indexPath.row])")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stuff.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableID", for: indexPath)
        cell.textLabel?.text = self.stuff[indexPath.row]
        cell.imageView?.image = self.images[indexPath.row]
        cell.detailTextLabel?.text = self.subText[indexPath.row]
        return cell
    }
    
    func setTable(loc : CLLocationCoordinate2D) {
        self.weather = WeatherFetch(url: "https://api.openweathermap.org/data/2.5/forecast?lat=\(loc.latitude)&lon=\(loc.longitude)&APPID=63dba0881a9c7a2ab8dd3666fe61c42c&units=metric", classView: self)
    }
    
    func setText(_ text : [List]) {
        for asd in text {
            stuff.append(asd.weather[0].description + " \(asd.main.temp) C")
            subText.append(asd.dt_txt)
        }
    }
    
    func setImages (img: Data) {
        self.images.append(UIImage(data: img)!)
    }
}
