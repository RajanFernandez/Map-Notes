//
//  MapViewController+MKMapViewDelegate.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController : MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? Site {
            
            let reuseID = "pin"
            
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                    
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                
            }
            return view
        }
        return nil
    }
    
}
