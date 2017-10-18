//
//  ImageExtension.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/18/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
   
    
    var widthImg: CGFloat{
        return size.width
    }
    
    var heightImg: CGFloat{
        return size.height
    }
    
    var centerPoint: CGPoint{
        return CGPoint(x: widthImg / 2, y: heightImg / 2)
    }
    var isPortrait: Bool{
        return size.height > size.width
    }
    
    var isLandscape: Bool{
        return size.width > size.height
    }
    
    var breadth: CGFloat{
        if isPortrait{
            return widthImg
        }else{
            return heightImg
        }

    }
    
    var breadthSize: CGSize{
        
        return CGSize(width: widthImg * 2, height: heightImg * 2)
        
    }
    
    var breadthRect: CGRect{
        return CGRect(origin: .zero, size: breadthSize)
    }
    
    var squaredImageForHome: UIImage?{
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
//        if isPortrait{
//            guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: centerPoint.x - (widthImg / 2), y: centerPoint.y - heightImg / 4), size: breadthSize)) else {return nil}
//            UIImage(cgImage: cgImage).draw(in: breadthRect)
//        }else{
//            guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: centerPoint.x - (widthImg / 4), y: centerPoint.y - heightImg / 2), size: breadthSize)) else {return nil}
//            UIImage(cgImage: cgImage).draw(in: breadthRect)
//
//        }

        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: centerPoint.x , y: centerPoint.y), size: breadthSize)) else {return nil}
            
//        UIImage(cgImage: cgImage).draw(in: breadthRect)
//        var currentContext = UIGraphicsGetImageFromCurrentImageContext()
//        let image = currentContext
//        currentContext = nil
//        UIGraphicsEndImageContext()
        let image = UIImage(cgImage: cgImage)
        return image

    }
    
    
}
