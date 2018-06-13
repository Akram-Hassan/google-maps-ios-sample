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
extension MapViewController: CLLocationManagerDelegate {
    enum PlaceType:String { case Mosque, Bank }
    
    private func getPlaceUrl(forType: PlaceType) -> String {
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(userLocation.coordinate.latitude),\(userLocation.coordinate.latitude)&radius=5000&type=\(forType.rawValue.lowercased())&key=\(GoogleApiKey)"
    }
    
    func getCurrentLocationInfo() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func showMapLocation(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.map = mapView
        
        mapView.camera = camera
        mapView.isHidden = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        
        manager.stopUpdatingLocation()
        
        showMapLocation(location: userLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("\(error)")
    }
}



