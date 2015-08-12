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
        if let asset:AVAsset = AVAsset.assetWithURL(url) as? AVAsset {
            
            // Fetch the duration of the video
            var durationSeconds = CMTimeGetSeconds(asset.duration)
            var assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            
            assetImgGenerate.appliesPreferredTrackTransform = true
            var error       : NSError? = nil
            
            // Jump to the third (1/3) of the video and fetch the thumbnail from there (600 is the timescale and is a multiplier of 24fps, 25fps, 30fps..)
            var time        : CMTime = CMTimeMakeWithSeconds(durationSeconds/3.0, 600)
            var img         : CGImageRef = assetImgGenerate.copyCGImageAtTime(time, actualTime: nil, error: &error)
            var frameImg    : UIImage = UIImage(CGImage: img)!
            
            return frameImg
        } else {
            return UIImage(named:"fallbackIcon")!
        }
    }
}
