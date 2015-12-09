//
//  SiteListTableViewController.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 8/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit
import CoreData

class SiteListTableViewController: UITableViewController {
    
    var locations = [Site]()
    
    let moc: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        // load the sites from the store
        let request = NSFetchRequest(entityName: "Site")
        do {
            locations = try moc.executeFetchRequest(request) as! [Site]
        } catch {
            print("Failed to get sites from the database")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SiteCell", forIndexPath: indexPath) as! SiteTableViewCell
        
        let site = locations[indexPath.row]
        cell.setWithSite(site)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = (sender as! SiteTableViewCell)
        let indexPath = self.tableView.indexPathForCell(cell)!
        let siteID = locations[indexPath.row].objectID
        let siteDetailVC = segue.destinationViewController as! SiteDetailTableViewController
        siteDetailVC.siteID = siteID

    }

}
