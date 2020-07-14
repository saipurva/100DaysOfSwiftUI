//
//  DiceResults.swift
//  RollDice
//
//  Created by Diana Harjani on 06/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct DiceResults: View {
    
    @EnvironmentObject var diceValue: DiceValue
    
    var body: some View {
        NavigationView{
            List{
                ForEach(diceValue.values, id: \.self) { dice in
                    VStack{
                        Text("You rolled  dice \(dice)")
                    }
                }
            }
            .navigationBarTitle("Diced Number")
          .navigationBarItems(trailing:  EditButton())
        }
    }
}

struct DiceResults_Previews: PreviewProvider {
    static var previews: some View {
        DiceResults()
    }
}
