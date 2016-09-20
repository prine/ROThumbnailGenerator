//
//  ImageThumbnailGenerator.swift
//  RASCOpublic
//
//  Created by Robin Oster on 11/08/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

class ImageThumbnailGenerator : ROThumbnailGenerator {
    
    var supportedExtensions:Array<String> = ["png", "jpg", "jpeg"]

    func getThumbnail(_ url:URL) -> UIImage {
        return UIImage(data: try! Data(contentsOf: url)) ?? UIImage(named: "Piktogramm_IMAGE")!
    }
}
