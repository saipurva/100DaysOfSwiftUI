//
//  AddView.swift
//  HabitTracking
//
//  Created by Diana Harjani on 17/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var habit = Habitss()

    @State private var name =  ""
    @State private var description = ""
    @State private var counter = 0
        
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Enter Activity", text: $name)
                TextField("Description of activity", text:  $description)
                Stepper(value: $counter, in: 0...100, step: 1){
                    Text("Completed \(counter) times")
                }
                
            }
        .navigationBarTitle("Add Activity")
        .navigationBarItems(trailing: Button("Save"){
            let item = Habititem(name: self.name, description: self.description, counter: self.counter)
                self.habit.items.append(item)
            self.presentationMode.wrappedValue.dismiss()
        })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habit: Habitss())
    }
}
