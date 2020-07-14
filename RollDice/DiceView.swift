//
//  DiceView.swift
//  RollDice
//
//  Created by Diana Harjani on 06/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    @State private var diceValues = Int.random(in: 1...6)
    @EnvironmentObject var diceValue: DiceValue
//    @Environment(\.presentationMode) var presentationMode
   
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("🎲")
                    .font(.custom("", size: 300))
                    .animation(.default)
                Button(action: {
                    // Roll Dice
                    
                    self.dicedNum()
                    //ACtion
                  /*  dice should randommly give a number between 1 and 6
                     and store the value in DiceResults.
                    
                    */
                }) {
                    Text("Roll Dice")
                        .font(.largeTitle)
                        .foregroundColor(Color.red)
                        .padding(20)

                        .background(Color.black)
                        .cornerRadius(30)
                }.animation(.easeIn)
                Text("Number Diced: \(diceValues) ")
                    .font(.title)
                
            }.background(Color.red)
        }
    }

    func dicedNum() {
        let dicedNumb = Int.random(in: 1...6)
        diceValues = dicedNumb
        diceValue.values.append(dicedNumb)
//        self.presentationMode.wrappedValue
        print(dicedNumb)
    }
    
  
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
