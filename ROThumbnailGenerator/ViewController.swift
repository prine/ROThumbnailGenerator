//
//  ViewController.swift
//  ROThumbnailGenerator
//
//  Created by Robin Oster on 12/08/15.
//  Copyright (c) 2015 Prine Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testPdf:UIImageView!
    @IBOutlet weak var testImage:UIImageView!
    @IBOutlet weak var testVideo:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbnail = ROThumbnail.sharedInstance
        
        let imageURL = NSBundle.mainBundle().URLForResource("TestImage", withExtension: "png")
        testImage.image = thumbnail.getThumbnail(imageURL!)
        
        let documentURL = NSBundle.mainBundle().URLForResource("TestPdf", withExtension: "pdf")
        testPdf.image = thumbnail.getThumbnail(documentURL!)
        
        let movieURL = NSBundle.mainBundle().URLForResource("TestMovie", withExtension: "mov")
        testVideo.image = thumbnail.getThumbnail(movieURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

