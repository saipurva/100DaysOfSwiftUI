//
//  ContentView.swift
//  ChallengeDay25
//
//  Created by Diana Harjani on 19/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var appChoice = Int.random(in: 0...2)
    @State private var player = false //player promt should win or loose
    @State private var ispresented = false
    @State private var playerscore = 0
    @State private var count = 0
    
    let counter = 10
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .purple, .orange]), startPoint: .topTrailing, endPoint: .bottomLeading)
            VStack {
                VStack{
                    Text("Rock, Paper, Scissors")
                        .font(.largeTitle)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .padding(20)
                        .foregroundColor(.blue)
                    Spacer()
                    Text("Your score is \(playerscore)")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.black)
                    Text("App chose \(moves[appChoice])") //PC chose ..
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.black)
                    //Text("You should ")
                    Text("Game Count: \(count)")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.black)
                    Text("SAI")
                    Spacer()
                }
                HStack { //Players response
                    
                    Button("Rock") {
                        self.sai(2)
                        self.player = true
                        self.play()
                    }.font(.system(size: 15, weight: .bold))
                        .background(Color.white)
                        .cornerRadius(30)
                        .padding(20)
                        .foregroundColor(.black)
                    
                    Button("Paper") {
                        self.sai(0)
                        self.play()
                        self.player = true
                    }.font(.system(size: 15, weight: .bold))
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(20)
                    .foregroundColor(.black)
                    
                    Button("Scissors") {
                        self.sai(1)
                        self.play()
                        self.player = true
                        //                    } .alert(isPresented: $player) {
                        //                        Alert(title: Text("The player Tapped"), message: Text("The app chose \(self.moves[appChoice])" + " Player scored \(playerscore)"), dismissButton: .default(Text("Continue")))
                    }.font(.system(size: 15, weight: .bold))
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(20)
                    .foregroundColor(.black)
                    .alert(isPresented: $ispresented) {
                        Alert(title: Text("Game Over"), message: Text("Your score is \(playerscore)"), dismissButton: .default(Text("Reset")) {
                            self.play()
                            })
                    }
                }
                Spacer()
            }
        }
        
    }
    
    func play(){
        moves.shuffle()
        appChoice = Int.random(in: 0...2)
        self.counted()
        print(playerscore)
        //        Int.random(in: self.$moves)
    }
    
    func sai(_ number: Int) {
        if number == appChoice {
            self.playerscore += 100
        }  else {
            if number != appChoice {
                self.playerscore -= 150
            }
        }
        count += 1
        counted()
    }
    
    func reset() {
        playerscore = 0
        count = 0
    }
    
    
    func counted() { //FIX COUNTER AND GAME OVER PROMPT ALERT
        if count == counter {
            //Game OVer
            ispresented = true
            print("Game over")
            reset()
        }
        
    }
    
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//MARK:-  old
// Image(self.item[self.number])
//            .resizable()
//            .frame(width: 300, height: 300)
//            .cornerRadius(20)
////            .background(Color.red)

//alert(isPresented: self.$player {
//                        Alert(title: Text("You "), message: Text("Your socre is "), dismissButton: .default(Text("ok")))
//                    })


// User input
//                Picker("rock, paper, scissors" ,selection: $user) {
//                    ForEach(0 ..< 3) {
//                        Text("\(self.item[$0])")
//                    }
//                }.pickerStyle((SegmentedPickerStyle()))

//PC Random
//                Picture(imagen: "\(self.$item)")

//                    Button(action: {
//                        //random(in: 0 ..< item.count)
//
//
//                        print(self.score)
//                        print(pc)
//                    }) {
//                        Text("Tap")
//                        //player tapped
//                    }
