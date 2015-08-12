//
//  PDFThumbnailGenerator.swift
//  RASCOpublic
//
//  Created by Robin Oster on 30/04/15.
//  Copyright (c) 2015 Rascor International AG. All rights reserved.
//

import UIKit

class PDFThumbnailGenerator : ROThumbnailGenerator {
    
    var supportedExtensions:Array<String> = ["pdf"]
    
    func getThumbnail(url:NSURL, pageNumber:Int, width:CGFloat) -> UIImage {
        var pdf:CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url as CFURLRef);
        
        var firstPage = CGPDFDocumentGetPage(pdf, pageNumber)
        
        var pageRect:CGRect = CGPDFPageGetBoxRect(firstPage, kCGPDFMediaBox);
        var pdfScale:CGFloat = width/pageRect.size.width;
        pageRect.size = CGSizeMake(pageRect.size.width*pdfScale, pageRect.size.height*pdfScale);
        pageRect.origin = CGPointZero;
        
        UIGraphicsBeginImageContext(pageRect.size);
        
        var context:CGContextRef = UIGraphicsGetCurrentContext();
        
        // White BG
        CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
        CGContextFillRect(context,pageRect);
        
        CGContextSaveGState(context);
        
        // Next 3 lines makes the rotations so that the page look in the right direction
        CGContextTranslateCTM(context, 0.0, pageRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(firstPage, kCGPDFMediaBox, pageRect, 0, true));
        
        CGContextDrawPDFPage(context, firstPage);
        CGContextRestoreGState(context);
        
        var thm:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return thm;

    }
    
    func getThumbnail(url:NSURL, pageNumber:Int) -> UIImage {
        return self.getThumbnail(url, pageNumber: pageNumber, width: 240.0)
    }
    
    func getThumbnail(url:NSURL) -> UIImage {
        return self.getThumbnail(url, pageNumber: 1, width: 240.0)
    }
}