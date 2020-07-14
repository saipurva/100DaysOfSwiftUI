//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Diana Harjani on 07/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct WelcomeView: View{
    var body: some View{
        VStack{
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            Text("Please select a resort from the left-hand menu; swipe from left edge to show it ")
                .foregroundColor(.secondary)
        }
    }
}
