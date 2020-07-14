//
//  Picture.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 14/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation

struct Picture: Codable, Identifiable, Hashable, Comparable{
    var id: UUID
    var pictureName: String
    var locations: [CodableMKPointAnnotation]
    
    static func <(lhs: Picture, rhs: Picture) -> Bool{
        lhs.pictureName < rhs.pictureName
    }
}
