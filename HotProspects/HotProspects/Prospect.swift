//
//  Prospect.swift
//  HotProspects
//
//  Created by Diana Harjani on 27/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var  name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
}

class Prospects: ObservableObject{
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() { //challenge 2
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey){
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//        self.people = []
        people = []
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Can't load saved data")
        }
        
    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
//    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    func clearAll(_ prospect: Prospect){
        people.removeAll()
    }
    
    private  func save(){
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(people)
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
