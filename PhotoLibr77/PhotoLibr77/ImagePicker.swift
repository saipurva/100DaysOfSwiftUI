//
//  ImagePicker.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 10/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable{
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
           let parent: ImagePicker
           
           init(_ parent: ImagePicker) {
               self.parent = parent
           }
           
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
               if let uiImage = info[.originalImage] as? UIImage{
                   parent.image = uiImage
               }
               parent.presentationMode.wrappedValue.dismiss()
           }
       }
    
}
    
    
    

