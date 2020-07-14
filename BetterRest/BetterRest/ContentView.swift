//
//  ContentView.swift
//  BetterRest
//
//  Created by Diana Harjani on 27/04/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    var coffeeIntake = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                //                VStack(alignment: .leading, spacing: 0) {
                Section(header: Text("When do you want to wake up?")) {
                    //                    Text("When do you want to wake up?")
                    //                    .font(.headline)
//                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                        .datePickerStyle(WheelDatePickerStyle())
                    VStack{
                        DatePicker("Please Enter a time", selection:  $wakeUp, displayedComponents:  .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                //                VStack(alignment: .leading, spacing: 0)  {
                //                    Text("Desired amount of sleep")
                //                        .font(.headline)
                Section(header: Text("Desired Amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                        
                    }
                }
                Section(header: Text("Daily Coffee Intake")) {
                    //                VStack (alignment: .leading, spacing: 0) {
                    //                    Text("Daily  coffee intake")
                    //                    Stepper(value: $coffeeAmount, in: 1...20) {
                    //                        if coffeeAmount == 1{
                    //                            Text("1 cup")
                    //                        } else {
                    //                            Text("\(coffeeAmount) cups")
                    //                        }
                    //                    }
                    Picker("Coffee intake", selection: $coffeeAmount) {
                        ForEach(0 ..< coffeeIntake.count) {
                            Text("\(self.coffeeIntake[$0])")
                        }
                    }.accessibility(label: Text("\(coffeeAmount) is your coffee intake")) // challenge2day 76 VOICe OVer 
                }
                Section(header: Text("Your ideal bedtime is")){
                    Text(bedTime)
                        .font(.headline)
                        .background(Color.yellow)
                        .foregroundColor(.blue)
                }
                
                
                
            }.navigationBarTitle("Better Rest")
            //            .navigationBarItems(trailing:
            //                Button(action: calculateBedTime) {
            //                    Text("Calculate")
            //                })
            //                .alert(isPresented: $showAlert) {
            //                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            //                }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var bedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var str = ""
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            str = formatter.string(from: sleepTime)
        } catch {
            print("Error")
            //something went wrong
        }
        return str
    }
    
    //    func calculateBedTime() {
    //        let model = SleepCalculator()
    //        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    //        let hour = (components.hour ?? 0) * 60 * 60
    //        let minute = (components.minute ?? 0) * 60
    //
    //
    //        do {
    //            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
    //            let sleepTime = wakeUp - prediction.actualSleep
    //            let formatter = DateFormatter()
    //            formatter.timeStyle = .short
    //
    //            alertMessage = formatter.string(from: sleepTime)
    //            alertTitle = "Your ideal bedtime is..."
    //        } catch {
    //            alertTitle = "Error"
    //            alertMessage = "Sorry, there was a problem calculating your bedtime."
    //            //something went wrong
    //        }
    //        showAlert = true
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
