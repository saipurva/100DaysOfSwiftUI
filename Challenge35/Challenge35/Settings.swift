////
////  Settings.swift
////  Challenge35
////
////  Created by Diana Harjani on 06/05/2020.
////  Copyright © 2020 Saipurva. All rights reserved.
////
//
//import SwiftUI
//
//struct Settings: View {
//    @State private var game = false
//    @State private var table = 0 //Table of
//    @State private var amountOfQuestion = [5, 10, 20]
//    @State private var questions = 1
//    
//    
//    var body: some View {
//        VStack{
//            Form{
//                Section(header: Text("Choose Table of...")){
//                    Stepper(value: $table, in: 0...12){
//                        Text("You chose table of:   \(self.table)")
//                    }
//                }
//                Section(header: Text("Choose Amount of Questions...")){
//                    Picker("", selection: $questions){
//                        ForEach(0..<amountOfQuestion.count){
//                            Text("\(self.amountOfQuestion[$0])")
//                        }
//                    }.pickerStyle(SegmentedPickerStyle())
//                }
//            }
//        }
//    }
//}
//
//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
