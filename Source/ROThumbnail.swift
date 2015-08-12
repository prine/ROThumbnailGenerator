//
//  ROThumbnail.swift
//  ROThumbnailGenerator
//
//  Created by Robin Oster on 12/08/15.
//  Copyright (c) 2015 Prine Development. All rights reserved.
//

import UIKit

public class ROThumbnail {
    
    public static let sharedInstance:ROThumbnail = ROThumbnail()
    private var supportedFiletypes:Dictionary<String, ROThumbnailGenerator> = [:]
    
    init() {
        self.initializeSupportedGenerators()
    }
    
    private func initializeSupportedGenerators() {
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
    
      :param: thumbnailGenerator:ROThumbnailGenerator The ROThumbnailGenerator implementation you want to add
    */
    public func addThumbnailGenerator(thumbnailGenerator:ROThumbnailGenerator) {
        for fileExtension in thumbnailGenerator.supportedExtensions {
            supportedFiletypes[fileExtension] = thumbnailGenerator
        }
    }
    
    /** 
       Analyses the file extension of the given url and uses the corresponding ROThumbnailGenerator
    
       :param: url:NSURL Defines the url you want to create a Thumbnail 
       :returns: UIImage It does create the created Thumbnail image
     */
    public func getThumbnail(url:NSURL) -> UIImage {
        if let fileExtension = url.pathExtension {
            var appropriateThumbnailGenerator = supportedFiletypes[fileExtension] ?? DefaultThumbnailGenerator()
            return appropriateThumbnailGenerator.getThumbnail(url)
        }
        
        return UIImage(named:"fallbackIcon")!
    }
}
