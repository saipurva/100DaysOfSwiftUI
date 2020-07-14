//
//  FilteringType.swift
//  CoreDataChallenges
//
//  Created by Diana Harjani on 26/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation

enum FilterType: String, CaseIterable{
    case beginsWith  = "BEGINSWITH"
    case beginsWithCaseSensitive = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsCaseSensitive = "CONTAINS[c]"
    case endsWith = "ENDSWITH"
    case endsWithCaseSensitive = "ENDSWITH[c]"
}
