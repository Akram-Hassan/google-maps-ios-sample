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
    func showMosqueLocations() {
        print("Mosques")
        loadPlacses(for: .Mosque)
    }
    
    func showBankLocations() {
        print("Banks")
        loadPlacses(for: .Bank)
    }
    
    func loadPlacses(for: PlaceType) {
        
    }
}
