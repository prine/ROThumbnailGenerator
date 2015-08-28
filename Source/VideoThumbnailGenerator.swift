//
//  VideoThumbnailGenerator.swift
//  RASCOpublic
//
//  Created by Robin Oster on 11/08/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit
import AVFoundation

class VideoThumbnailGenerator : ROThumbnailGenerator {
    
    var supportedExtensions:Array<String> = ["mov", "m4a"]
    
    func getThumbnail(url: NSURL) -> UIImage {
        if let asset:AVAsset = AVAsset(URL:url) {
            
            // Fetch the duration of the video
            let durationSeconds = CMTimeGetSeconds(asset.duration)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            assetImgGenerate.appliesPreferredTrackTransform = true
            var error       : NSError? = nil
            
            // Jump to the third (1/3) of the video and fetch the thumbnail from there (600 is the timescale and is a multiplier of 24fps, 25fps, 30fps..)
            let time        : CMTime = CMTimeMakeWithSeconds(durationSeconds/3.0, 600)
            var img         : CGImageRef
            do {
                img = try assetImgGenerate.copyCGImageAtTime(time, actualTime: nil)
                let frameImg    : UIImage = try UIImage(CGImage: img)
                
                return frameImg
            } catch let error1 as NSError {
                error = error1
                // FIXME: Check if this is not invoking any unwanted behaviour
                // img = nil
            }
        } else {
            return UIImage(named:"fallbackIcon")!
        }
        
        return UIImage(named:"fallbackIcon")!
    }
}
