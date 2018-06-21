//
//  Home.swift
//  google-maps-ios-sample
//
//  Created by Akram Hassan on 6/20/18.
//  Copyright © 2018 aktech. All rights reserved.
//

import Foundation
import CoreLocation

enum PlaceType: String, Decodable { case Mosque, Bank }

struct HomeModel : Decodable{
    var locationType: PlaceType = .Mosque
    var userLocation:GeoLocation!
    var places: [Place] = []
}

struct LocationModel {
    var userLocation:GeoLocation!
    var destination:GeoLocation!
}

struct GeoLocation : Decodable  {
    let longitude: Double
    let latitude: Double
}

struct Place : Decodable {
    let location: GeoLocation
    let name: String
}


