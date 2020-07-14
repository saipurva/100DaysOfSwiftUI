//
//  ContentView.swift
//  Instafilter
//
//  Created by Diana Harjani on 31/05/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    let context = CIContext()
    
    @State private var showAlert = false
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: { self.filterIntensity },
            set: { self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        let radius = Binding<Double>(
            get: { self.filterRadius },
            set: {self.filterRadius =  $0
                self.applyProcessing()
        })
        
        
       return NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill( Color.secondary)
                    if image != nil {
                        image?
                        .resizable()
                        .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }.onTapGesture {
                    self.showingImagePicker = true
                }
                Text("You chose \(currentFilter.name) filter") //CHallenge 67.2
                VStack{
                    HStack{
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    HStack{ //challenge 67.3 
                        Text("Radius")
                        Slider(value: radius)
                    }
                    .padding(.vertical)
                    HStack{
                        Button("Change Filter"){
                            self.showingFilterSheet = true
                        }
                        Spacer()
                        
                        Button("Save"){
                            guard let processedImage = self.processedImage else {
                                self.showAlert.toggle() //Challange 67.1
                                return }
                            let imageSaver = ImageSaver()
                            
                            imageSaver.successHandler = {
                                print("Success")
                            }
                            imageSaver.errorHandler = {
                                print("Oops: \($0.localizedDescription)")
                            }
                            imageSaver.writeToPhotoAlbum(image: processedImage)
                            if self.image == nil {
                                self.showAlert = true
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("InstaFilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet){
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Cristallize")) {
                        self.setFilter(CIFilter.crystallize())},
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges())},
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur())},
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate())},
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone())},
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask())},
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette())},
                    .cancel()
                ])
            }
            .alert(isPresented: $showAlert){
                Alert(title: Text("Error"), message: Text("Select a picture"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)        }
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



