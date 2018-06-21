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
        showCurrentLocationMarker()
        
        mapView.isHidden = false
        
        showMosqueLocations()
    }
    
    func showCurrentLocationMarker() {
        let camera = GMSCameraPosition.camera(withLatitude: model.userLocation.latitude,
                                              longitude: model.userLocation.longitude,
                                              zoom: zoomLevel)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: model.userLocation.latitude, longitude: model.userLocation.longitude)
        marker.title = "My location"
        marker.map = mapView

        mapView.camera = camera
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
            model.locationType = .Mosque
            showMosqueLocations()
        case 1:
            model.locationType = .Bank
            showBankLocations()
        default:
            break
        }
    }
    
    func showSelectedPlaces() {
        
        for place in model.places {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
            let color = model.locationType == .Bank ? UIColor.blue : UIColor.brown
            marker.icon = GMSMarker.markerImage(with: color)
            marker.title = place.name
            marker.snippet = model.locationType.rawValue
            marker.map = mapView
        }
    }
}



