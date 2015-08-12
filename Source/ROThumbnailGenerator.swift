//
//  ThumbnailGenerator.swift
//  RASCOpublic
//
//  Created by Robin Oster on 11/08/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

/**
    ROThumbnailGenerator class is the protocol for implementing your own ThumbnailGenerators
    You can easily add yourself to the ROThumbnail class
 */
public protocol ROThumbnailGenerator {
    
    // Define the exensions which are supported by this thumbnail generator implementation
    var supportedExtensions:Array<String> { get }

    /**
        Create a UIImage thumbnail from the given URL
    
        :param: url The url to the document the thumbnail should be generated.
    
        :returns: thumbnail The created thumbnail image.
      */
    func getThumbnail(url:NSURL) -> UIImage;
}