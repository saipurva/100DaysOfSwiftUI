//
//  ContentView.swift
//  flagss
//
//  Created by Diana Harjani on 16/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI





struct ContentView: View {
   let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var countries = ["Estonia", "Italy", "France", "Spain", "US", "UK", "Germany", "Ireland", "Poland", "Russia", "Nigeria", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score  = 100
    
    @State private var animationcount = 0.0
    @State private var opac = [1.0, 1.0, 0.25]
    @State private var wrong =  [Color.green, Color.orange, Color.blue]
    
    struct Flagtype: View {
        var image: String
        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
                .shadow(color: .black, radius: 2)
//                .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
        }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack{
                    Text("Tap the Flag Of: ")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Flagtype(image: self.countries[number])
                          .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
                       // Image(self.countries[number])
                        //                            .renderingMode(.original)
                        //                            .clipShape(Capsule())
                        //                            .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
                        //                            .shadow(color: .black, radius: 2)
                    }
                        
                    .rotation3DEffect(.degrees(self.animationcount), axis: (x: 0, y: 30, z: 0))
                    .opacity(self.opac[number])
                    .background(self.wrong[number])
                    
                    
                }
                Text("Score is: \(self.score)")
                    .foregroundColor(.white)
                Spacer()
            }
                
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your Score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "True"
            score += 100
            withAnimation{
                self.animationcount += 360
                for i in 0..<self.opac.count {
                    opac[i] = (i == correctAnswer) ? 1.0 : 0.25
                }
            }
        } else {
            if number != correctAnswer {
                scoreTitle = "False, that's the flag of \(countries[number])"
                score -= 150
                withAnimation{
                    for i in 0..<self.wrong.count {
                        wrong[i] = (i != correctAnswer) ? Color.orange : Color.green
                    }
                }
            }
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        for i in 0..<self.opac.count {
            opac[i] = 1.0
        }
        for i in 0..<self.wrong.count {
            wrong[i] = .blue
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
