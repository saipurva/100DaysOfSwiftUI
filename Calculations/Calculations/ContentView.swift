//
//  ContentView.swift
//  Calculations
//
//  Created by Diana Harjani on 03/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var gameActive = false
    @State private var askingSettings = false
    
    @State private var correctAnswer = ""
    @State private var numbers = 3
    @State private var amountQuestion = [5, 10, 20]
    @State private var numb = 2
    @State private var table = Int.random(in: 0...10)
    @State private var multiplier = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].shuffled()
    @State private var numbs = 3
    
    @State private var score = 0
    
   // @State private var questions = []()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Text("Multiplication Quiz")
                .font((.largeTitle))
                .foregroundColor(.orange)
                .background(Color.purple)
            Group{//asking questions to the user
                Form{
                    Stepper(value: $numbers, in: 0...12){
                        Text("Table of \(numbers)")
                    }
                   
                    Picker("Number of questions", selection: $numb) {
                        ForEach(0..<amountQuestion.count){              Text("Select \(self.amountQuestion[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            Section(header: Text("game")){
                Button("Settings") {
                    
                    self.askingSettings.toggle()
                }
                Button("Start Game"){
                    self.gameActive.toggle()
                }
                Text("How much is \(numbers) x \(multiplier[numbs])")
                TextField("answers...", text: $correctAnswer)
                    .keyboardType(.decimalPad)
                Text("Your score is: \(score)")
                Text("\(self.player)")
                
            }
        }
    }
    
    var player: Int {
        
        if self.numb == self.amountQuestion[numb] {
            self.score += 10
            
        } else {
            if self.numb != self.amountQuestion[numb] {
                self.score += 10
                askQuestion()
                //next question
            }
        }
        return score
    }
    
    func askQuestion() {
        multiplier.shuffled()
       
    }
    
//    var score: Int{
//        var points = 0
//        let answer = numbers * multiplier[numbs]
//        let respust = Int(correctAnswer) ?? 0
//        if answer == respust {
//            points += 10
//        } else {
//            if answer != respust {
//                points -= 5
//            }
//        }
//        return points
//        //multiplier.shuffled()
//    }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
