//
//  ContentView.swift
//  CoreDataChallenges
//
//  Created by Diana Harjani on 26/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @FetchRequest(entity: Singer.entity(), sortDescriptors: []) var singers: FetchedResults<Singer>
    
    let sortDescriptors =  [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]
    
    @State private var filteringStyle = FilterType.beginsWith
    let arrayOfFilterType: Array<FilterType>  = FilterType.allCases
    
    var body: some View {
        NavigationView{
            VStack{
                //FilteredList(filter: lastNameFilter)
//                FilteredList(filterKey: "lastName",  filterValue: lastNameFilter) {(singer: Singer) in //CHALLENGE !
//                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName) ")
//                }
                FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: sortDescriptors, filteringType: filteringStyle) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName) ")

                }
                
                Button("Add Examples"){
                    let taylor = Singer(context: self.moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
                    
                    let ed = Singer(context: self.moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"
                    
                    let adele = Singer(context: self.moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    let armaan = Singer(context: self.moc)
                    armaan.firstName = "Armaan"
                    armaan.lastName = "Maalik"
                    
                    let nigam = Singer(context: self.moc)
                    nigam.firstName = "Sonu"
                    nigam.lastName = "Nigam"
                    
                    try? self.moc.save()
                }
                HStack{
                    Button("Show A"){
                        //self.lastNameFilter = "A"
                        self.lastNameFilter = self.filter(letter: "A")
                    }
                    
                    Button("Show S"){
                        //self.lastNameFilter = "S"
                        self.lastNameFilter = self.filter(letter: "S")
                    }
                    Button("Show N"){
//                        self.lastNameFilter = "N"
                        self.lastNameFilter = self.filter(letter: "N")
                    }
                }
                Picker("For filtering Style", selection: $filteringStyle)  {
                   ForEach(arrayOfFilterType, id: \.self) {
                       filterType in
                       Text("\(filterType.rawValue)")
                   }
               }.pickerStyle(SegmentedPickerStyle())
                   .colorMultiply(Color.red)
            }
        .navigationBarTitle("Singers")
        .navigationBarItems(trailing: EditButton())
        }
    }
    
    func filter(letter: String) -> String {
        switch filteringStyle{
        case .beginsWith:
            return letter.capitalized
        case .beginsWithCaseSensitive:
            return letter.lowercased()
        case .contains:
            return letter
        case .containsCaseSensitive:
            return letter.lowercased()
        case .endsWith:
            return letter.lowercased()
        default:
            return letter.lowercased()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
