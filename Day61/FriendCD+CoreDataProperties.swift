//
//  FriendCD+CoreDataProperties.swift
//  Day61
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCD> {
        return NSFetchRequest<FriendCD>(entityName: "FriendCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
