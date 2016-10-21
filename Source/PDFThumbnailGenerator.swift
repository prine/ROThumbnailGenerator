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
        let pdf:CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url as CFURLRef)!;
        
        let firstPage = CGPDFDocumentGetPage(pdf, pageNumber)
        
        var pageRect:CGRect = CGPDFPageGetBoxRect(firstPage!, CGPDFBox.MediaBox);
        let pdfScale:CGFloat = width/pageRect.size.width;
        pageRect.size = CGSizeMake(pageRect.size.width*pdfScale, pageRect.size.height*pdfScale);
        pageRect.origin = CGPointZero;
        
        UIGraphicsBeginImageContext(pageRect.size);
        
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        
        // White BG
        CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
        CGContextFillRect(context,pageRect);
        
        CGContextSaveGState(context);
        
        // Next 3 lines makes the rotations so that the page look in the right direction
        CGContextTranslateCTM(context, 0.0, pageRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(firstPage!, CGPDFBox.MediaBox, pageRect, 0, true));
        
        CGContextDrawPDFPage(context, firstPage!);
        CGContextRestoreGState(context);
        
        let thm:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        
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
