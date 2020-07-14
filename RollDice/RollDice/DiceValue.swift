//
//  DiceValue.swift
//  RollDice
//
//  Created by Diana Harjani on 06/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation

class DiceValue: ObservableObject, Codable, Identifiable {
    var id = UUID()
    var values =  [Int]()
}


class DicedValues: ObservableObject{
    @Published private var dicy: [DiceValue]
    
    static let saveKey = "SavedData"
    
    init() { //challenge 2
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey){
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//        self.people = []
        dicy = []
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        do {
            let data = try Data(contentsOf: filename)
            dicy = try JSONDecoder().decode([DiceValue].self, from: data)
        } catch {
            print("Can't load saved data")
        }
        
    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
//    }
    
    func add(_ diced: DiceValue) {
        dicy.append(diced)
        save()
    }
    
   
    func clearAll(_ diced: DiceValue){
        dicy.removeAll()
    }
    
    private  func save(){
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(dicy)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
        }
        catch {
            print("Data couldn't be saved in Documents Directory")
        }
    }
    
    func getDocumentsDirectory() -> URL {
           let  paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return paths[0]
       }
    
}
