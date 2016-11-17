//
//  ROThumbnail.swift
//  ROThumbnailGenerator
//
//  Created by Robin Oster on 12/08/15.
//  Copyright (c) 2015 Prine Development. All rights reserved.
//

import UIKit

open class ROThumbnail {
    
    open static let sharedInstance:ROThumbnail = ROThumbnail()
    open var imageQuality:CGFloat = 1.0 // Default is 100% JPEG image quality
    fileprivate var supportedFiletypes:Dictionary<String, ROThumbnailGenerator> = [:]
    
    init() {
        self.initializeSupportedGenerators()
    }
    
    fileprivate func initializeSupportedGenerators() {
        // Add all per default added Thumbnail generators
        // If you want to add your own thumbnail generator use the method ROThumbnail.sharedInstance.addThumbnailGenerator(yourGenerator)
        addThumbnailGenerator(ImageThumbnailGenerator())
        addThumbnailGenerator(PDFThumbnailGenerator())
        addThumbnailGenerator(VideoThumbnailGenerator())
    }
    
    /**
      Add your own implementation of ROThumbnailGenerator to the ROThumbnail class
      It does automatically add the supported extensions in the internal dictionary and make therefor
      the new genorator accessible for the getThumbnail methods
    
      - parameter thumbnailGenerator:ROThumbnailGenerator: The ROThumbnailGenerator implementation you want to add
    */
    open func addThumbnailGenerator(_ thumbnailGenerator:ROThumbnailGenerator) {
        for fileExtension in thumbnailGenerator.supportedExtensions {
            supportedFiletypes[fileExtension.lowercased()] = thumbnailGenerator
        }
    }

    /**
       Analyses the file extension of the given url and uses the corresponding ROThumbnailGenerator
    
       - parameter url:NSURL: Defines the url you want to create a Thumbnail 
       - returns: UIImage It does create the created Thumbnail image
     */
    open func getThumbnail(_ url:URL) -> UIImage {
        let fileExtension = url.pathExtension
        
        let appropriateThumbnailGenerator = supportedFiletypes[fileExtension.lowercased()] ?? DefaultThumbnailGenerator()
        var thumbnail = appropriateThumbnailGenerator.getThumbnail(url)

        // Don't perform compression if image quality is set to 100%
        if imageQuality < 1 {
            // Image quality of the thumbnail is defined in the imageQuality variable, can be setted from outside
            let jpeg:Data = UIImageJPEGRepresentation(thumbnail, imageQuality)!
            thumbnail = UIImage(data: jpeg)!
        }
        
        
        return thumbnail
    }
}
