//
//  SiteDetailTableViewController.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 9/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class SiteDetailTableViewController: UITableViewController {
    
    var siteID: NSManagedObjectID? = nil
    var site: Site? = nil
    var currentLocation: CLLocation? = nil
    
    let moc: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationItem.leftBarButtonItem == nil && siteID == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("cancelButtonPressed"))
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if siteID != nil {
            getSiteWithSiteID()
        } else if currentLocation != nil {
            newSiteWithLocation(currentLocation!)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // gets an existing site from the store with the managed object id
    func getSiteWithSiteID() {
        
        do {
            site = try moc.existingObjectWithID(siteID!) as? Site
            self.navigationItem.title = site!.title
        } catch {
            print("Could not get the requested site from the store")
        }
        
    }
    
    func newSiteWithLocation(location: CLLocation) {
        
        site = NSEntityDescription.insertNewObjectForEntityForName("Site", inManagedObjectContext: moc) as? Site
        if site != nil {
            site!.setWithCLLocation(currentLocation!)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Site Name"
        case 1:
            return "Location"
        case 2:
            return "Notes"
        default:
            return nil
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell")! as! TitleTableViewCell
            if site?.title != nil {
                cell.textField.text = site!.title
            }
            return cell

        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("CoordinateCell")!
            switch indexPath.row {
            case 0:
                cell.textLabel!.text = "Latitude"
                cell.detailTextLabel?.text = site?.latString()
            case 1:
                cell.textLabel!.text = "Longitude"
                cell.detailTextLabel?.text = site?.lonString()
            default:
                break
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell")!
            if site?.note == nil || site?.note == "" {
                cell.textLabel!.text = "Note"
                cell.textLabel!.textColor = UIColor.grayColor()
            } else {
                cell.textLabel!.text = site?.note
                cell.textLabel!.textColor = UIColor.blackColor()
            }
            return cell
    
        default:
            let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "default")
            return cell
        }

    }
    
    
    // MARK: Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! TitleTableViewCell
            cell.textField.becomeFirstResponder()
        case 2:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        default:
            break
        }
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonPressed() {
        
        tableView.endEditing(true)
        
        // get the site properties
        let titleCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TitleTableViewCell
        site!.title = titleCell.textField.text
        // GET NOTE CELL CONTENTS HERE
        
        // save the site and return
        do {
            try moc.save()
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        } catch {
            
            let alert = UIAlertController(title: "Error", message: "Sorry, there was an error saving the site", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func cancelButtonPressed() {
        
        tableView.endEditing(true)
        
        // remove the site from the context and dismiss the view
        if site != nil {
            moc.deleteObject(site!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
