//
//  DetailedView.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 14/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI
import MapKit

struct  DetailedView: View {
    
    var picture: Picture
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var centerCoordinate = CLLocationCoordinate2D()
   
    
    var body: some View{
        
        VStack{
            Text(picture.pictureName)
            
            if image != nil {
                image?
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(30)
            } else {
             Text("Image not found")
            }
            
            MapView(centerCoordinate: $centerCoordinate, annotations: picture.locations)
            
    
        }
        .onAppear{
            self.loadImage()
        }
    }
    
    func loadImage(){
        let data = ManageData.loadImage(pathName: picture.id.uuidString)
        guard let loadedData = data else {
            return
        }
        self.inputImage = UIImage(data: loadedData)
        self.image = Image(uiImage: inputImage!)
    }
    
//    func deleteItems(at offsets: IndexSet) {
//        let image = pictures[offsets.first!]
//        print(image.pictureName)
//
//        ManageData.deleteImage(pathName: image.id.uuidString)
//        pictures.remove(atOffsets: offsets)
//
//        ManageData.savedPictures(pathName: "Pictures", pictures: self.pictures)
//    }
}

