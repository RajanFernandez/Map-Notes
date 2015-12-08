//
//  SiteDetailNavViewController.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 8/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit

class SiteDetailNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(segue: UIStoryboardSegue) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveButton(segue: UIStoryboardSegue) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
