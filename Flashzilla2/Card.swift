//
//  Card.swift
//  Flashzilla2
//
//  Created by Diana Harjani on 03/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct Card: Codable {
    let prompt: String
    let answer: String
    
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
