//
//  SiteDetailTableViewController+UITextViewDelegate.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 9/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit

extension SiteDetailTableViewController : UITextViewDelegate {
    
    // updates the site note when the textview ends editing
    func textViewDidEndEditing(textView: UITextView) {
        if site != nil {
            site!.note = textView.text
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 2)], withRowAnimation: UITableViewRowAnimation.None
            )
        }
    }
    
}