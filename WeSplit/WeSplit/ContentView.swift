//
//  ContentView.swift
//  WeSplit
//
//  Created by Diana Harjani on 13/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
//    @State private var isRed = false
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculae totalper person
        let amountPerPerson = Double(numberOfPeople) ?? 0
        let tipNumber = Double(tipPercentages[tipPercentage])
        let amountNumber = Double(checkAmount) ?? 0
        
        let tipValue = amountNumber / 100 + tipNumber
        let grandtotal = amountNumber + tipValue
        let totalPerPerson = grandtotal / amountPerPerson
        return totalPerPerson
    }
    
    var totalAmount: Double {
        let tipNumber = Double(tipPercentages[tipPercentage])
        let amountNumber = Double(checkAmount) ?? 0
       
        let tipValue = amountNumber / 100 + tipNumber
        let total = amountNumber + tipValue
        return total
    }
    
    var isRed: Bool { //CHALLENGE DAY 24
        if tipPercentages[tipPercentage] == 0  {
            return true
        } else {
            return false
        }
        
    }
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                    TextField("Number of People", text: $numberOfPeople)
                        
                    .keyboardType(.alphabet)

                    }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach( 0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")) {
                  //Text(" $\(totalPerPerson, specifier: "%2.f")")
                    Text("$\(totalPerPerson)")
                    .keyboardType(.decimalPad)
                }
                Section(header: Text("Total Amount")) {
//                    self.tipPercentages[4]
                    
                    Text("$\(totalAmount)")
                        .foregroundColor(self.isRed ? .red : .blue)
                }
            }
            .navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
