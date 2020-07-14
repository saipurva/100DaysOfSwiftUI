//
//  ContentView.swift
//  Challenge35
//
//  Created by Diana Harjani on 04/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var setting = false  //making player choose settings.
    @State private var game = false //play game
    
    @State private var table = 0 //Table of
    @State private var amountOfQuestion = [5, 10, 20]
    @State private var questions = 1
    //In play game
    @State private var multipier = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].shuffled()
    @State private var multipliers = 0
    //multiplier that changes. randomly everytime user answers question
    @State private var answer = ""
    
    
    @State private var score = 0
    @State private var questcount = 0
    
    //alert
    @State private var showAlert = false
    @State private var alertTittle = ""
    @State private var alertMessage = ""
    
    @State private var animationcount = 360
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack{
                Text("Multiplying Quiz")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding(15)
                    .background(Color.blue)
                     .cornerRadius(30)
                    
                
                Stepper(value: $table, in: 0...12){
                    Text("You chose table of:   \(self.table)")
                }.background(Color.green)
                
                Picker("", selection: $questions){
                    ForEach(0..<amountOfQuestion.count){
                        Text("\(self.amountOfQuestion[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .background(Color.green)
                Button(action: {
                    //self.askQuestion()
                }){
                    Text("Start game")
                }
                VStack(spacing: 20){
                    Text("You chose table of \(table) and \(amountOfQuestion[questions])")
                        .background(Color.yellow)
                    Text("How much is \((multipier[multipliers])) x \(table)?")
                        .font(.title)
                        .background(Color.purple)
                        .cornerRadius(40)
                        .animation(.interactiveSpring())
                }
                TextField("answer is", text: $answer){
                    self.points()
                    }
                .keyboardType(.numberPad)
                .padding(20)
                .foregroundColor(.black)
                .background(Color.red)
                
                Spacer()
                Text("Questions remaining \(questcount) of \(amountOfQuestion[questions])")
                    .font(.body)
                    .foregroundColor(.gray)
                Text("Your score is :  \(score)")
                    .bold()
                    .foregroundColor(.orange)
                    .padding(20)
                    .background(Color.green)
                    .cornerRadius(20)
                
            }.alert(isPresented: $showAlert){
            Alert(title: Text(alertTittle), message: Text(alertMessage), dismissButton: .default(Text("Continue")){
            self.askQuestion()
            }
            )}
        }
    }


    
    //MAKE ALERT AFTER ANSWER IS PUT,TO CHECK ANSWE, SCORE AND ,EXT QUESTION
    func points(){
        let correctAnswer = multipier[multipliers] * table
        let ans = Int(answer) ?? 0
        if correctAnswer == ans {
            score += 10
            alertTittle = "Correct!"
            alertMessage = "Your score is \(score)"
            
        } else {
            if correctAnswer != ans {
                alertTittle = "Wrong, correct answer is \(correctAnswer)"
                alertMessage = "Your score is \(score)"
            }
        }
        if questcount != amountOfQuestion[questions] {
            self.questcount += 1
        } else
            if questcount == amountOfQuestion[questions] {
                //game over, showtotal score, reset
                reset()
        }
        showAlert = true
    }
    
    
    func askQuestion(){
        multipier.shuffle()
    }
    
    func reset(){
        showAlert = true
        alertTittle = "You scored \(score), well done!"
        alertMessage = "Choose table and amount of questions"
        score = 0
        questcount = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
