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
    
    func getThumbnail(_ url:URL, pageNumber:Int, width:CGFloat) -> UIImage {
        let pdf:CGPDFDocument = CGPDFDocument(url as CFURL)!;
        
        let firstPage = pdf.page(at: pageNumber)
        
        var pageRect:CGRect = firstPage!.getBoxRect(CGPDFBox.mediaBox);
        let pdfScale:CGFloat = width/pageRect.size.width;
        pageRect.size = CGSize(width: pageRect.size.width*pdfScale, height: pageRect.size.height*pdfScale);
        pageRect.origin = CGPoint.zero;
        
        UIGraphicsBeginImageContext(pageRect.size);
        
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        
        // White BG
        context.setFillColor(red: 1.0,green: 1.0,blue: 1.0,alpha: 1.0);
        context.fill(pageRect);
        
        context.saveGState();
        
        // Next 3 lines makes the rotations so that the page look in the right direction
        context.translateBy(x: 0.0, y: pageRect.size.height);
        context.scaleBy(x: 1.0, y: -1.0);
        context.concatenate((firstPage?.getDrawingTransform(CGPDFBox.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))!);
        
        context.drawPDFPage(firstPage!);
        context.restoreGState();
        
        let thm:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        return thm;

    }
    
    func getThumbnail(_ url:URL, pageNumber:Int) -> UIImage {
        return self.getThumbnail(url, pageNumber: pageNumber, width: 240.0)
    }
    
    func getThumbnail(_ url:URL) -> UIImage {
        return self.getThumbnail(url, pageNumber: 1, width: 240.0)
    }
}
