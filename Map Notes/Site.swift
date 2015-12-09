//
//  Site.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import Foundation
import CoreData
import MapKit


class Site: NSManagedObject, MKAnnotation {

    func setWithCLLocation(location: CLLocation) {

        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D.init(latitude: self.latitude!.doubleValue, longitude: self.longitude!.doubleValue)
    }
    
    var subtitle: String? {
        return coordinatesString()
    }
    
    func latString() -> String? {
        
        if latitude != nil {
            
            let north = latitude!.doubleValue >= 0.0 ? true : false
            let lat = north ? latitude!.doubleValue : latitude!.doubleValue * -1
            let latDir = north ? "N" : "S"
            return String(format: "%.6f %@", arguments: [lat, latDir])
            
        }
        return nil
    }
    
    func lonString() -> String? {
        
        if longitude != nil {
            
            let east = longitude!.doubleValue >= 0.0 ? true : false
            let lon = east ? longitude!.doubleValue : longitude!.doubleValue * -1
            let lonDir = east ? "E" : "W"
            return String(format: "%.6f %@", arguments: [lon, lonDir])
            
        }
        return nil
    }
    
    func coordinatesString() -> String? {
        
        if latString() != nil && lonString() != nil {
            return String(format: "%@, %@", arguments: [latString()!, lonString()!])
        }
        return nil
    }
    
    
    
}
