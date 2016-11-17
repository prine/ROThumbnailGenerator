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
    
    var supportedExtensions:Array<String> = ["mov", "m4a", "mp4"]
    
    func getThumbnail(_ url: URL) -> UIImage {
        let asset:AVAsset = AVAsset(url:url)
            
        // Fetch the duration of the video
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        assetImgGenerate.appliesPreferredTrackTransform = true

        // Jump to the third (1/3) of the video and fetch the thumbnail from there (600 is the timescale and is a multiplier of 24fps, 25fps, 30fps..)
        let time        : CMTime = CMTimeMakeWithSeconds(durationSeconds/3.0, 600)
        var img         : CGImage
        do {
            img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let frameImg: UIImage = UIImage(cgImage: img)
            
            return frameImg
        } catch let error as NSError {
            print("ERROR: \(error)")
            return UIImage(named:"fallbackIcon")!
        }
    }
}
