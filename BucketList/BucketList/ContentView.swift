//
//  ContentView.swift
//  BucketList
//
//  Created by Diana Harjani on 04/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit


struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    @State private var isUnlocked = false
    
    @State private var errorAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack{
            if isUnlocked{
                Unlocked() //chalenge 2
            } else {
                Button("Unlock Places"){
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
               .alert(isPresented: $errorAlert){
                          Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                      }
            }
        }
        .onAppear(perform: loadData)
       
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData(){
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData(){
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else { //chalenge 3
                        self.errorAlert = true
                        self.errorTitle = "ID not recognized"
                        self.errorMessage = "Please try again"
                        print("No touch ID")
                        
                    }
                }
            }
        } else {  //challenge3
            errorAlert = true
            errorTitle = "Error"
            errorMessage = "Set ID identifier"
            print("No Biometrics")
            //no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
