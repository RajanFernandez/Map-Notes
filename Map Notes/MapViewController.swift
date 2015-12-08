//
//  ViewController.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit
import MapKit
import CoreData

let SITE_ENTITY = "Site"

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var locations = [Site]()
    
    let moc: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        // load the sites in the database
        let request = NSFetchRequest(entityName: "Site")
        do {
            locations = try moc.executeFetchRequest(request) as! [Site]
        } catch {
            print("Failed to get sites from the database")
        }
        
        self.mapView.addAnnotations(self.locations)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dropPin(sender: AnyObject) {
        
        let siteDetailView = self.storyboard?.instantiateViewControllerWithIdentifier("SiteDetailNav")
        self.presentViewController(siteDetailView!, animated: true, completion: nil)
        
//        if currentLocation != nil {
//            
//            // Save the current location
//            let message = String(format: "%@, %@\n\nPlease enter a description", arguments: [latString(self.currentLocation!), lonString(self.currentLocation!)])
//            let alert = UIAlertController(title: "Save location", message: message, preferredStyle: .Alert)
//            alert.addTextFieldWithConfigurationHandler({ (text) -> Void in
//                text.placeholder = "Site description"
//            })
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//            let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
//                let description = alert.textFields!.first!.text
//                self.saveSiteWithLocation(self.currentLocation!, title: description)
//            })
//            alert.addAction(cancelAction)
//            alert.addAction(saveAction)
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//        } else {
//            
//            // Location manager has not determined the location yet
//            let alert = UIAlertController(title: "Unknown location", message: "Please wait for the GPS location to update.", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//        }
        
    }
    
    func saveSiteWithLocation(location: CLLocation, title: String?) {
        
        let site = NSEntityDescription.insertNewObjectForEntityForName(SITE_ENTITY, inManagedObjectContext: moc) as! Site
        site.setWithCLLocation(location, andTitle: title)
        
        do {
            try moc.save()
        } catch {
            print("Failed to save location")
        }
        
        self.mapView.addAnnotation(site)
        
        self.locations.append(site)
        
    }
    
    func latString(location: CLLocation) -> String {
        
        let lat = self.currentLocation!.coordinate.latitude
        let latDir = (lat >= 0) ? "N" : "S"
        let latString = String(format: "%.6f, %@", arguments: [lat, latDir])
        
        return latString
    
    }
    
    func lonString(location: CLLocation) -> String {
      
        let lon = self.currentLocation!.coordinate.longitude
        let lonDir = (lon >= 0) ? "E" : "W"
        let lonString = String(format: "%.6f, %@", arguments: [lon, lonDir])
        
        return lonString
        
    }
    
    @IBAction func siteDetailWasCancelled (sender: AnyObject) {
        
    }

}

