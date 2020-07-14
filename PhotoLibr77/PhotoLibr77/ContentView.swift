//
//  ContentView.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 10/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var image: Image?
    //    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //    @State private var pictureName = ""
    @State private var pictures =  [Picture]().sorted()
    @State private var showingEditPictureView = false

    let locationFetcher  = LocationFetcher()
    
    
    let context = CIContext()
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView{
            //LIST Of imported images should appear here
            List{
                ForEach(pictures, id: \.self) { picture in
                    NavigationLink(destination: DetailedView(picture: picture)) {
                        Text(picture.pictureName)
                        
                    }
                }
            }
           .navigationBarTitle("Photo Library")
          .navigationBarItems(leading: EditButton(), trailing: Button( action: {
                      self.showingEditPictureView = true }, label: { Image(systemName: "plus")
                  }))
          .sheet(isPresented: $showingEditPictureView, onDismiss: nil) { SelectedPicture(pictures: self.$pictures)}
          .onAppear{
                  self.pictures = ManageData.loadPictures(pathName: "Pictures")
          }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        let image = pictures[offsets.first!]
        print(image.pictureName)
        
        ManageData.deleteImage(pathName: image.id.uuidString)
        pictures.remove(atOffsets: offsets)
        
        ManageData.savedPictures(pathName: "Pictures", pictures: self.pictures)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
