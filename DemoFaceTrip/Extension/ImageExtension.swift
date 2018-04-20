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
        return size.width >= size.height
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
    
    var cropImageForHome: UIImage?{
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
    
    func cropImage(image:UIImage)-> UIImage {
        let width = image.size.width
        let height = image.size.height
        
        var centerPoint: CGPoint{
            return CGPoint(x: width / 2, y: height / 2)
        }
        guard let cgImage = image.cgImage?.cropping(to: CGRect(origin: CGPoint(x: centerPoint.x , y: centerPoint.y), size: CGSize(width: image.size.width * 2, height: image.size.height * 2))) else {return image}
        
        let img = UIImage(cgImage: cgImage)
        return img

        
    }
    
    func cropImageForSlideShow(sizeView: CGSize) -> UIImage {
        
        guard  let cgImage = self.cgImage else {
            return self
        }
        let contextImage = UIImage(cgImage: cgImage)
        let contextSize = contextImage.size
        let widthView = sizeView.width
        let heightView = sizeView.height
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        
        var cropWidth = widthView
        var cropHeight = heightView
        
        let cropAspect: CGFloat = widthView / heightView
        
        if isLandscape{
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        }else{
            cropWidth = contextSize.width
            cropHeight = contextSize.height / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)

        let imageRef = contextImage.cgImage?.cropping(to: rect)
        let cropped = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        UIGraphicsBeginImageContextWithOptions(sizeView, true, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: widthView, height: heightView))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
       
        return UIImage()
    }
    
}
