//
//  Site.swift
//  Ecogecko
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import Foundation
import CoreData
import MapKit


class Site: NSManagedObject, MKAnnotation {

    func setWithCLLocation(location: CLLocation, andTitle title: String?) {

        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.title = title
        
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D.init(latitude: self.latitude!.doubleValue, longitude: self.longitude!.doubleValue)
    }
    
    var subtitle: String? {
        return "Subtitle"
    }
    
}
