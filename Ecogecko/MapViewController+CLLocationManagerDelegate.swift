//
//  MapViewController+CLLocationManagerDelegate.swift
//  Ecogecko
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // update the current location property
        if locations.count > 1 {
            self.currentLocation = locations[locations.count - 1]
        } else {
            self.currentLocation = locations[0]
        }
        
        // update the label over the map
        if self.currentLocation != nil {
            let lat = latString(currentLocation!)
            let lon = lonString(currentLocation!)
            let format = (interfaceOrientation == .Portrait) ? "%@\n %@" : "%@, %@"
            locationLabel.text = String(format: format, arguments: [lat, lon])
        } else {
            locationLabel.text = "No GPS lock"
        }
    }
    
}