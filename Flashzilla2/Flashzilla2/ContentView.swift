//
//  ContentView.swift
//  Flashzilla2
//
//  Created by Diana Harjani on 03/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    
    enum TypeOfSheet{
        case editView
        case settingsView
    }
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentitateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var showingEditScreen = false
    
    @State private var isActive = true
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //challenge 2
    @State var reanswer = false
    @State private var showingSettingView = false
    @State private var typeOfSheet = TypeOfSheet.editView
    @State private var showingSheet = false
    
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75))
                if self.timeRemaining == 0 { // challenge 1, date 91
                    withAnimation{
                        Text("Time over")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
                
                ZStack{
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index], reanswer: self.reanswer) { (correct) in
                            withAnimation{
                                self.removeCard(at: index, isSuccess: correct)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack(alignment: .leading) {
                HStack {
                        Button(action: {
                            self.typeOfSheet = .editView
                            self.showingSheet = true
//                            self.showingEditScreen = true
                            
                        }) {
                            Image(systemName: "plus.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                
                Spacer()
                    Button(action: {
//                        self.showingSettingView = true
                        self.typeOfSheet = .settingsView
                       self.showingSheet = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if !differentitateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    HStack{
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1, isSuccess: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your  answer as being incorrect."))
                        Spacer()
                        Button(action: {
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1, isSuccess: true)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7)
                                    .clipShape(Circle()))
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct"))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
            
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in self.isActive = false }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards, content: {
            if self.typeOfSheet == .editView{
                EditView()
            } else if self.typeOfSheet == .settingsView{
                SettingsView(reanswer: self.reanswer)
            }
        })
//        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
//            EditView()
//        }
//        .sheet(isPresented: $showingSettingView){
//            SettingsView(reanswer: true)
//        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, isSuccess: Bool){
        guard index >= 0 else { return }
        
        let card = cards.remove(at: index)
        
        if reanswer && !isSuccess {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards.insert(card, at: 0)
            }
        }
//        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }

    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "Cards"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func restackCard(at index: Int){
        guard index >= 0 else { return }
        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
