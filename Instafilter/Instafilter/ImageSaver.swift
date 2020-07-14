//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Diana Harjani on 01/06/2020.
//  Copyright © 2020 Saipurva. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //save complete
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
