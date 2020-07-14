//
//  SettingsView.swift
//  Flashzilla2
//
//  Created by Diana Harjani on 03/07/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var reanswer: Bool
    var body: some View {
        NavigationView{
            Form{
                Section(){
                    Toggle(isOn: $reanswer){ Text("Choose to reanswer")}
                }
            }
        .navigationBarTitle("Settings")
        .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(reanswer: true)
    }
}
