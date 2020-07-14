//
//  SelectedPicture.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 10/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI
import MapKit

struct SelectedPicture: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var pictures: [Picture]
    
    @State private var imageName = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingSourceTypeAlert = false
    @State private var pickerSourceType = UIImagePickerController.SourceType.photoLibrary
    
    let locationFetcher = LocationFetcher()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("Name filed", text: $imageName)
                        .foregroundColor(Color.blue)
                        .multilineTextAlignment(.center)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                    } else {
                        Button(action: {
                            self.showingSourceTypeAlert = true
                        }) {
                            Text("select Image")
                        }
                        .foregroundColor(Color.black)
                        .padding(.top, 100)
                        
                    }
                }
                Spacer()
                MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                    .frame(width: 300, height: 300)
                
                HStack{
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = ""
                        newLocation.coordinate = self.centerCoordinate
                        self.locationFetcher.start()
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
//                        self.showingEditScreen = true
                    }) { Image(systemName: "plus")
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .clipShape(Circle().size(width: 30, height: 30))
                        .padding(.trailing)
                    }
                }
                HStack{
                    Button("Start Tracking Location"){
                        self.locationFetcher.start()
                    }
                    Button("Read Location"){
                        if let location = self.locationFetcher.lastKnownLocation{
                            print("Your location is \(location)")
                        } else {
                            print("Your location is unknown")
                        }
                    }
                    
                
                    
                }
            }
            .navigationBarTitle("Add Picture")
            .navigationBarItems(trailing: Button(action: { self.savePictures()}, label: { Text("Save")
                
            }))
            .alert(isPresented: $showingPlaceDetails){
                Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place inforation"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Edit")) { self.showingEditScreen = true })
            }
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData){
                if self.selectedPlace != nil {
                   ContentView()
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: addNewImage) {
                    ImagePicker(image: self.$inputImage)
                    
            }
            .alert(isPresented: $showingSourceTypeAlert, content: { () -> Alert in
                if imageName.isEmpty {
                    return Alert(title: Text("Image Name is Empty"), message: Text("Please enter an Image Name"), dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text("Take a photo from: "), message: nil, primaryButton: .default(Text("Photo Library"), action: {
                        self.pickerSourceType = .photoLibrary
                        self.showingImagePicker = true
                    }), secondaryButton: .default(Text("Camera"), action: {
                        self.pickerSourceType = .camera
                        self.showingImagePicker = true
                    }))
                }
            })
        }
    }
    
    func addNewImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //            if pickerSourceType == .camera{
        //
        //            }
    }
    
    func savePictures(){
        let picture = Picture(id: UUID(), pictureName: self.imageName, locations: locations)
        self.pictures.append(picture)
        ManageData.savingImage(pathName: picture.id.uuidString, inputImage: self.inputImage)
        ManageData.savedPictures(pathName: "Pictures", pictures: self.pictures)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveData(){
        do {
            let filename = ManageData.getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let  data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
}



