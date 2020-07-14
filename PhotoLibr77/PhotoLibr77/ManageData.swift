//
//  ManageData.swift
//  PhotoLibr77
//
//  Created by Diana Harjani on 14/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import Foundation
import SwiftUI

class ManageData{
    static func loadPictures(pathName: String) -> [Picture] {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: filename)
            let pictures = try JSONDecoder().decode([Picture].self, from: data)
            return pictures
        } catch {
            print("Unable to load  saved data")
        }
        return []
    }
    
    static func savedPictures(pathName: String, pictures: [Picture]) {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do{
            let data = try JSONEncoder().encode(pictures)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch { print("Unable to save data")}
    }
    
    static func savingImage(pathName: String, inputImage: UIImage?) {
        let fileName = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: fileName, options: [.atomicWrite,  .completeFileProtection])
            }
        } catch {
            print("Unable to save image")
        }
    }
    
    static func deleteImage(pathName: String) {
        let fileName = self.getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            try FileManager.default.removeItem(at: fileName)
        } catch {
            print("Unable to delete picture")
        }
    }
    
    static func loadImage(pathName: String) -> Data? {
        let fileName = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: fileName)
            return data
        } catch {
            print("Unable to load image")
        }
        return nil
    }
    
    static func getDocumentsDirectory() -> URL {
        // find all possible document directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one,
        return paths[0]
    }
    
}
