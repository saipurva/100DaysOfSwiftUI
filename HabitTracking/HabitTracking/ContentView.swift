//
//  ContentView.swift
//  HabitTracking
//
//  Created by Diana Harjani on 17/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct Habititem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let counter: Int 
}

class Habitss: ObservableObject {
    @Published  var items = [Habititem]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded  = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
        
        init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Habititem].self, from: items){
            self.items  = decoded
            return
                }
            }
        self.items = []
        }
}

struct ContentView: View {
    @ObservedObject var habit = Habitss()
    
    @State private var ispresented = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(habit.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(Color.green)
                            Text(item.description)
                            
                        }
                        Spacer()
                        Text("Count: \(item.counter)")
                            .foregroundColor(Color.blue)
                            .bold()
                    }.background(Color.yellow)
                }
                .onDelete(perform: removeRows)
            }
            .navigationBarTitle("Activity Tracker")
            .navigationBarItems(leading: EditButton().sheet(isPresented: $ispresented){
                    AddView(habit: self.habit)
                    },trailing: Button(action: {
                        self.ispresented = true
                    }){
                        Image(systemName: "plus")
                    })
        }    }
    func removeRows(at offsets: IndexSet){
        habit.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
