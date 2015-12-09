//
//  SiteTableViewCell.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 9/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell {

    func setWithSite(site: Site) {
        self.textLabel!.text = site.title
        self.detailTextLabel?.text = site.coordinatesString()
    }

}
