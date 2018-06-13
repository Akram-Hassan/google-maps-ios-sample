//
//  MapViewController - Networking.swift
//  google-maps-ios-sample
//
//  Created by Akram Hassan on 6/13/18.
//  Copyright © 2018 aktech. All rights reserved.
//

import Foundation
import UIKit

extension MapViewController {
    
    enum PlaceType:String { case Mosque, Bank }
    
    private func getPlaceUrl(forType: PlaceType) -> String {
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(userLocation.coordinate.latitude),\(userLocation.coordinate.latitude)&radius=\(radius)&type=\(forType.rawValue.lowercased())&key=\(GoogleApiKey)"
    }
    
    func showMosqueLocations() {
        print("Mosques")
        loadPlacses(forType: .Mosque)
    }
    
    func showBankLocations() {
        print("Banks")
        loadPlacses(forType: .Bank)
    }
    
    func loadPlacses(forType: PlaceType) {
        // Set up the URL request
        let placeUrl: String = getPlaceUrl(forType: forType)
        let url = URL(string: placeUrl)
        let urlRequest = URLRequest(url: url!)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling URL")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let place = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The place is: " + place.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let placeName = place["name"] as? String else {
                    print("Could not get place title from JSON")
                    return
                }
                print("The place is: " + placeName)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    func placeLoaded(for: PlaceType) {
        
    }
    
    
    func makeGetCall() {

    }
}
