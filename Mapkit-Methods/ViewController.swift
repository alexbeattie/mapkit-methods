//
//  ViewController.swift
//  Mapkit-Methods
//
//  Created by Alex Beattie on 8/20/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var geoCoder: CLGeocoder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        setup()
        
    }

    func setup() {
        
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView!.showsUserLocation = true
        
    }
 
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
       
        self.currentLocation = userLocation.location
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 250, 250)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func addAnnotationToMap() {

        self.geoCoder.reverseGeocodeLocation(self.currentLocation!) { (placemarks, error) in
            if error != nil{ return }
            let placemark:CLPlacemark = placemarks![0] as! CLPlacemark
            print(placemark)
            
            if let streetName = placemark.addressDictionary!["Street"] as? String {
                
                DispatchQueue.main.async {
                  let annotation = Annotation(coordinate: self.currentLocation!.coordinate, title: "You're right here fucker!", subtitle: streetName)
                  self.mapView!.addAnnotation(annotation)
                }
            }
        }
    }
  
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(motion == .motionShake) {
            addAnnotationToMap()
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Mappin")
        if (annotation == nil) {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Mappin")
            annotationView?.canShowCallout = true
        }
        else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
}

