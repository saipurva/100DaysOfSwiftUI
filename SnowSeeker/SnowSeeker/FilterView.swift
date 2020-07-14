//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Diana Harjani on 08/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let sizeArray = ["All", "Small", "Average", "Large"]
    let priceArray = ["All", "$", "$$", "$$$"]
    
    @Binding var countryFilt: String
    @Binding var sizeFilt: Int
    @Binding var priceFilt: Int
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select size for filtering")) {
                    Picker(selection: $sizeFilt
                    , label: Text("Select size for filtering")) {
                        ForEach(0 ..< self.sizeArray.count) { number in
                            Text("\(self.sizeArray[number])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                       
                }
                Section(header: Text("Select price for filtering: ")) {
                    Picker(selection: $priceFilt, label: Text("Select price for filtering")) {
                        ForEach(0 ..< self.priceArray.count){ number in
                            Text("\(self.priceArray[number])")
                        }
                    }
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                self.dismiss()
            }, label: {
                Text("Done")
            }))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
