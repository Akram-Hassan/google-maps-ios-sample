//
//  MapViewController - Map and Location.swift
//  google-maps-ios-sample
//
//  Created by Akram Hassan on 6/13/18.
//  Copyright © 2018 aktech. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps


//Map and Location Functionality
extension HomeViewController: CLLocationManagerDelegate {

    func getCurrentLocationInfo() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func showMapLocation(location: GeoLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                              longitude: location.longitude,
                                              zoom: zoomLevel)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.map = mapView
        
        mapView.camera = camera
        mapView.isHidden = false
        
        showMosqueLocations()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        model.userLocation = GeoLocation(longitude: location!.coordinate.longitude as Double, latitude: location!.coordinate.latitude as Double)
        
        manager.stopUpdatingLocation()
        
        showMapLocation(location: model.userLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("\(error)")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            showMosqueLocations()
            model.locationType = .Mosque
        case 1:
            showBankLocations()
            model.locationType = .Bank
        default:
            break
        }
    }
}



