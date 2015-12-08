//
//  Site+CoreDataProperties.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 7/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Site {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var title: String?

}
