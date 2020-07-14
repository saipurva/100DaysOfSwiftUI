//
//  ContentView.swift
//  WordScramble
//
//  Created by Diana Harjani on 29/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var scores = 0
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                GeometryReader { geometry in
                    List(self.usedWords, id: \.self) { word in
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(Color(red: Double((geo.frame(in: .global).maxY) / 800), green: 0.5, blue: Double((geo.frame(in: .global).maxY / (geometry.size.height) * 700)))) //day94 challenge 3
                                Text(word)
                                    
                            }
                            .offset(x: max(0, geo.frame(in: .global).minY / (geometry.size.height) * geo.frame(in: .global).maxY - 85)) //day 94 challenge 2
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                        }
                    }
                    Text("\(self.scores)")
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError)  {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(trailing: Button(action: reset) { Text("New Game")  })
        }
    }
    
    func addNewWord() {
        //llowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if answer.count >= 1  || newWord.count < 0 {
            scores += 10
        }
        //exit if the remaining string is empty
        //        guard answer.count > 0 else {
        //            return
        //        }
        guard answer.count >= 3 else { //challenge 1.
            wordError(title: "", message: "Minimum characters 3")
            return
        }
        //Extra validation to come
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make up, you know")
            scores -= 5
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            scores -= 5
            return
        }
        if rootWord == newWord {
            wordError(title: "Both words are same", message: "Error")
            return
        }
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    func reset() { //challenge 2
        scores = 0
        startGame()
        usedWords.removeAll()
        // addNewWord()
    }
    func startGame() {
        //1. Find the URL for start.txt in our app bundle.
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //2. Load start.txt intoa string
            if let startWords = try? String(contentsOf: startWordsURL) {
                //3. split the string up into an array of strings, splitting on line breaks.
                let allWords = startWords.components(separatedBy: "\n")
                //4. Pick one random word, or use "silkworm as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                //5. If we are here everything has worked out, so we can exit.
                return
            }
        }
        //if we are here then there was a problem - triger a crash and report
        fatalError("Could not load start.txt from bundle.")
        
    }
    //Is the word original? it hasn't been used already
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    // is the word possible?
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    //is the word real /UIKit checker
    func isReal(word: String) -> Bool {
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    
    //error
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
