//
//  ViewController.swift
//  On soc
//
//  Created by Ferran Olivella on 1/4/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Setting up ManagerLocation
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        
        var userLocation: CLLocation = locations[0] as! CLLocation
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                println(error)
                
            } else {
                // ? because we don't know if exists
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
                    // We print the placemark!
//                    println(p)
                    
                    var subThoroughFare: String = ""
                    
                    if (p.subThoroughfare != nil) {
                        subThoroughFare = p.subThoroughfare
                    }
                        
                    self.addressLabel.text = "\(subThoroughFare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                    
                }
                
                
            }
            
            
            
        })
        
    }


}

