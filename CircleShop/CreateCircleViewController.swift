//
//  CreateCircleViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/27/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CreateCircleViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var circleNameTextField: UITextField!
    
//    var circles: [Circle]!
    

    let manager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            manager.requestWhenInUseAuthorization()
            
            
        } else {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        
        slider.addTarget(self, action: Selector("sliderMoved"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func sliderMoved() {
        let delta : Double = Double(slider.value * 0.01)
        let span = MKCoordinateSpanMake(delta, delta)
        let center = mapView.userLocation.location.coordinate
        var zoomRegion : MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(zoomRegion, animated: false)
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            
            if status != CLAuthorizationStatus.NotDetermined {
                mapView.showsUserLocation = true
            }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                
                self.textView.text = self.getLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func getLocationInfo(placemark: CLPlacemark!) -> String {
        var locationName = ""
        if (placemark != nil) {
            //stop updating location to save battery life
            manager.stopUpdatingLocation()
            let locality = placemark.locality != nil ? placemark.locality : ""
            let postalCode = placemark.postalCode != nil ? placemark.postalCode : ""
            let administrativeArea = placemark.administrativeArea != nil ? placemark.administrativeArea : ""
            let country = placemark.country != nil ? placemark.country : ""
            
            locationName = locality + ", " + postalCode + ", " + administrativeArea + ", " + country
        }
        return locationName
    }

    @IBAction func doneCreation(sender: AnyObject) {
        
        if let name = circleNameTextField.text {
            CurrentUser.addCircle(name, location: manager.location, callback: { (succeeded, error) -> Void in
                if succeeded {
                    self.navigationController!.popViewControllerAnimated(true)
                } else {
                    Helpers.showSimpleAlert(self, title: "Fuck", message: "Failed to save!")
                }

            })
        } else {
            Helpers.showSimpleAlert(self, title: "Fuck", message: "Could you input the fucking name please!")
        }
    }
    
}

