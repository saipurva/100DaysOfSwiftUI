//
//  UserCD+CoreDataProperties.swift
//  Day61
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var company: String?
    @NSManaged public var about: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var parent: FriendCD?
    
    
    public var Name: String {
        name ?? "unknown name"
    }
    
    public var address: String {
        address ?? "Unknown address"
    }
    
    public var email: String{
        email ?? "Unknown email"
    }

    public var company: String {
        company ?? "Unknown company"
    }
    
    public var about: String {
        about ?? "Unknown about"
    }
    
    public  var friendCD?: [FriendCD]{
    let set = friend as? Set<UserCD> ?? []
    
    return set.sorted { $0.name < $1.name }
    }
}
