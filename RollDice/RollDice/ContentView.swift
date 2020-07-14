//
//  ContentView.swift
//  RollDice
//
//  Created by Diana Harjani on 06/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected  = 0
    
    
    var diceValues = DiceValue()
    
    var body: some View {
        TabView(selection: $tabSelected){
            DiceView()
                
                .tabItem{
                    Image(systemName: "cube.fill")
                    Text("Roll Dice")
            }.tag(0)
            DiceResults()
                
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Results")
            }.tag(1)
        }
    .environmentObject(diceValues)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
