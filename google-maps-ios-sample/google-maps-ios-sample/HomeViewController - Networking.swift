//
//  MapViewController - Networking.swift
//  google-maps-ios-sample
//
//  Created by Akram Hassan on 6/13/18.
//  Copyright © 2018 aktech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

extension HomeViewController {
    
    
    private func getPlaceUrl(forType: PlaceType) -> String {
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(model.userLocation.latitude),\(model.userLocation.longitude)&radius=\(radius)&type=\(forType.rawValue.lowercased())&key=\(GoogleApiKey)"
    }
    
    func showMosqueLocations() {
        print("Mosques")
        loadSelectedPlaces(forType: .Mosque)
    }
    
    func showBankLocations() {
        print("Banks")
        loadSelectedPlaces(forType: .Bank)
    }
    
    func loadSelectedPlaces(forType: PlaceType)  {
        mapView.clear()
        showCurrentLocationMarker()
        
        let webServiceUrl = getPlaceUrl(forType: forType)
        Alamofire.request(webServiceUrl)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let results = json["results"]
                    var places:[Place] = []
                    
                    for (_,result):(String, JSON) in results {
                        let name = result["name"].stringValue
                        let long = result["geometry"]["location"]["lng"].doubleValue
                        let lat = result["geometry"]["location"]["lat"].doubleValue
                        let geoLocation = GeoLocation(longitude: long, latitude: lat)
                        
                        places.append( Place(location: geoLocation, name: name) )
                    }
                    
                    self.model.places = places
                    self.showSelectedPlaces()
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
}
