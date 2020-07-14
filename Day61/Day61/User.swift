//
//  User.swift
//  Day61
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable{
    var id: String
    var name: String
    var age: Int
    var address: String
    var company: String
    var email: String
    var about: String
    var friends: [Friend]
    var tags: [String]
    var registered: Date
    
    var isActive: Bool
    
    
    var formattedRegisteredDate: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM dd, yyyy"
            return dateFormatter.string(from: registered)
        }
    }
}
