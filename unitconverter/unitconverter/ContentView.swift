//
//  ContentView.swift
//  unitconverter
//
//  Created by Diana Harjani on 14/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var inNumber = 0
    @State private var outNumber = 2
        
//    let inUnit = [0, 32, 273]
 //   let temp = Int(inUnit[inNumber])
//    var result: Double {
//        let number = Double(name) ?? 0
//
//        let cels = Measurement(value: (number), unit: UnitTemperature.celsius)
//        let fah = Measurement(value: (number), unit: UnitTemperature.fahrenheit)
//        let kelv = Measurement(value: (number), unit: UnitTemperature.kelvin)
//        return number
//    }
     let input = ["Celsius", "Fahrenheit", "Kelvin"]
     let output = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var celsconver: Double {
        let number = Double(name) ?? 0
        switch inNumber {
        case 0:
            return number + 0
        case 1:
            return number + 32
        case 2:
            return number + 273
        default:
            return 0
        }
    }
   
    var tempconv: Measurement<UnitTemperature> {
        let temperature = celsconver
        let degree = Measurement(value: temperature, unit: UnitTemperature.celsius)
        let fahrenheit = degree.converted(to: UnitTemperature.fahrenheit)
        let kelvin = degree.converted(to: UnitTemperature.kelvin)
        
        switch outNumber {
        case 0:
            return degree
        case 1:
            return fahrenheit
        case 2:
            return kelvin
        default:
            return degree
        }
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input temperature")){
                    Picker(selection: $inNumber, label: Text("hello")) {
                        ForEach(0 ..< input.count) {
                            Text("\(self.input[$0]) degrees")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Enter value", text: $name)
                        .keyboardType(.numberPad)
                }
               
                Section(header: Text( "Output")) {
                    Picker(selection: $outNumber, label: Text("")) {
                        ForEach(0 ..< output.count) {
                            Text(self.output[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("Temperature is \(tempconv) degrees")
                }
            }
            .navigationBarTitle("Om Sai Ram")
        }
    }
}

//As we have three user values here – their input number, their input unit, and their output unit – you need to have three @State properties to store them all. You’ll need a textfield plus two segmented controls, plus a text view to show your output, and that’s about it.



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
