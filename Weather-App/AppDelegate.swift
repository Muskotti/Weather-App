//
//  AppDelegate.swift
//  Weather-App
//
//  Created by Toni Vänttinen on 08/10/2019.
//  Copyright © 2019 Toni Vänttinen. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    var current: ViewController?
    var forecast: ForecastViewController?
    var cities: CitiesViewController?
    
    var manager : CLLocationManager?
    var locations : CLLocationCoordinate2D?
    
    var geoCoder = CLGeocoder()
    var location : CLLocation?
    
    var placeP: CLPlacemark?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navi = window?.rootViewController as! UITabBarController
        current = navi.viewControllers![0] as? ViewController
        forecast = navi.viewControllers![1] as? ForecastViewController
        cities = navi.viewControllers![2] as? CitiesViewController
        
        forecast?.appdel = self
        current?.appdel = self
        
        self.manager = CLLocationManager()
        self.manager?.requestAlwaysAuthorization()
        self.manager?.requestWhenInUseAuthorization()
        
        setLocation()
        
        return true
    }
    
    func setLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager?.startUpdatingLocation()
            
            self.locations = self.manager?.location?.coordinate
            self.location = CLLocation(latitude: (self.locations?.latitude)!, longitude: (self.locations?.longitude)!)
            geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
                var place: CLPlacemark!
                place = placemarks?[0]
                self.placeP = placemarks?[0]
                self.current?.setLocation(loc: self.locations!, place: place)
                self.forecast?.setTable(loc: self.locations!)
                self.cities?.giveClasses(cur: self.current!, fore: self.forecast!)
            })
        }
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

