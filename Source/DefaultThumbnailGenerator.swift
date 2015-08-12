//
//  DefaultThumbnailGenerator.swift
//  RASCOpublic
//
//  Created by Robin Oster on 11/08/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

class DefaultThumbnailGenerator : ROThumbnailGenerator {
    
    var supportedExtensions:Array<String> = []
    
    func getThumbnail(url: NSURL) -> UIImage {
        return UIImage(named:"fallbackIcon")!
    }
}
