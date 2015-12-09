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
    
    override func viewWillAppear(animated: Bool) {
        
        // set up the location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func dropPin(sender: AnyObject) {
//        
//        if currentLocation != nil {
//            
//            let siteDetailView = self.storyboard?.instantiateViewControllerWithIdentifier("SiteDetailView") as! SiteDetailTableViewController
//            siteDetailView.currentLocation = currentLocation
//            self.presentViewController(siteDetailView, animated: true, completion: nil)
//            
//        } else {
//            print("No GPS Lock")
//        }
//    }
    
    func saveSiteWithLocation(location: CLLocation) -> NSManagedObjectID {
        
        // save the new site to the store
        let site = NSEntityDescription.insertNewObjectForEntityForName(SITE_ENTITY, inManagedObjectContext: moc) as! Site
        site.setWithCLLocation(location)
        
        do {
            try moc.save()
        } catch {
            print("Failed to save location")
        }
        
        // update the map and the view controller
        self.mapView.addAnnotation(site)
        self.locations.append(site)
        
        // return the new site id
        return site.objectID
        
    }
    
    func latString(location: CLLocation) -> String {
        
        let latitiude = self.currentLocation!.coordinate.latitude
        
        let north = latitiude >= 0.0 ? true : false
        let lon = north ? latitiude : latitiude * -1
        let lonDir = north ? "N" : "S"
        
        return String(format: "%.6f %@", arguments: [lon, lonDir])
    }
    
    func lonString(location: CLLocation) -> String {
      
        let longitude = self.currentLocation!.coordinate.longitude
        
        let east = longitude >= 0.0 ? true : false
        let lon = east ? longitude : longitude * -1
        let lonDir = east ? "E" : "W"
        
        return String(format: "%.6f %@", arguments: [lon, lonDir])
    }
    
    func coordinateString(location: CLLocation) -> String {
        
        return String(format: "%@, %@", arguments: [latString(location), lonString(location)])
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DropPin" {
            let siteDetailNavVC = segue.destinationViewController as! UINavigationController
            let siteDetailVC = siteDetailNavVC.viewControllers.first as! SiteDetailTableViewController
            siteDetailVC.currentLocation = currentLocation
        }
        
        
    }

}

