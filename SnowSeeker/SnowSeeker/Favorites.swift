//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Diana Harjani on 07/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject{
    
    // resorts the user has favorited
    private var resorts: Set<String>
    
    //key we are using to read and write userDefaults
    private let saveKey = "Favorites"
    
    init(){
        //load our savedDAta
        //Day 99 challenge 2
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
           }
        //use an empty array
        self.resorts = []
    }
    
    //returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    //adds the resort to our set, updates all views, and saves changes
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    //removes resort, uodates and saves
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){ //day 99 challenge 2
        //write out our data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

}
