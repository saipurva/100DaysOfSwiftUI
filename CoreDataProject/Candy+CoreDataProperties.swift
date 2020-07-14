//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Diana Harjani on 25/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String{
        name ?? "Unknown Candy"
    }
}
