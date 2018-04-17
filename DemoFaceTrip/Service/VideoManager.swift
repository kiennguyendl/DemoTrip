//
//  VideoManager.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/1/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import Photos
import UIKit

class VideoManager: NSObject {
    
    static let shareInstance = VideoManager()
    
    let imagesPerSecond: TimeInterval = 3
    
    func getThumnailImage(image: UIImage) -> UIImage {
        let sizeImg = image.size
        var croppedSize: CGSize?
//        var ratio: CGFloat = 64.0
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        
        if sizeImg.width > sizeImg.height{
            offsetX = (sizeImg.height - sizeImg.width) / 2
            croppedSize = CGSize(width: sizeImg.height, height: sizeImg.height)
        }else{
            offsetY = (sizeImg.width - sizeImg.height) / 2
            croppedSize = CGSize(width: sizeImg.width, height: sizeImg.width)
        }
        
        let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1, width: (croppedSize?.width)!, height: (croppedSize?.height)!)
        
        let imageRef = image.cgImage?.cropping(to: clippedRect)
        
        let image: UIImage = UIImage(cgImage: imageRef!, scale: image.scale, orientation: image.imageOrientation)
        
        
        return image
    }
    
    func getThumnailVideo(asset: AVAsset) -> UIImage{
        
        do {
            
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(10, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return UIImage()
            
        }
    }
    
    func generateVideoFromListImage(listImage: [UIImage], viewSize: UIView, completionHandler: @escaping (URL)->Void) {
        var listImage = listImage
//        let outputSize = viewSize.frame
        let outputSize = CGSize(width: 1920, height: 1280)
        let videoURL = NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/VideoGenFromImage.MP4")
        removeFileAtURLIfExists(url: videoURL)
        
        guard let videoWriter = try? AVAssetWriter(outputURL: videoURL as URL, fileType: AVFileType.mp4) else {
            fatalError("AVAssetWriter error")
        }
        
        let outputSettings = [AVVideoCodecKey : AVVideoCodecType.h264, AVVideoWidthKey : NSNumber(value: Float(outputSize.width)), AVVideoHeightKey : NSNumber(value: Float(outputSize.height))] as [String : Any]
        guard videoWriter.canApply(outputSettings: outputSettings, forMediaType: AVMediaType.video) else {
            fatalError("Negative : Can't apply the Output settings...")
        }
        
        let videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: outputSettings)
        let sourcePixelBufferAttributesDictionary = [kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32ARGB), kCVPixelBufferWidthKey as String: NSNumber(value: Float(outputSize.width)), kCVPixelBufferHeightKey as String: NSNumber(value: Float(outputSize.height))]
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoWriterInput, sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)
        if videoWriter.canAdd(videoWriterInput) {
            videoWriter.add(videoWriterInput)
        }
        
        if videoWriter.startWriting() {
            let zeroTime = CMTimeMake(Int64(imagesPerSecond),Int32(1))
            print("start session: \(zeroTime)")
            videoWriter.startSession(atSourceTime: zeroTime)
            
            assert(pixelBufferAdaptor.pixelBufferPool != nil)
            let media_queue = DispatchQueue(label: "mediaInputQueue")
            videoWriterInput.requestMediaDataWhenReady(on: media_queue, using: { () -> Void in
                let fps: Int32 = 1
                let framePerSecond: Int64 = Int64(self.imagesPerSecond)
                let frameDuration = CMTimeMake(Int64(self.imagesPerSecond), fps)
                var frameCount: Int64 = 0
                var appendSucceeded = true
                while (listImage.count > 0) {
                    if (videoWriterInput.isReadyForMoreMediaData) {
                        let nextPhoto = listImage.remove(at: 0)
                        let lastFrameTime = CMTimeMake(frameCount * framePerSecond, fps)
                        let presentationTime = frameCount == 0 ? lastFrameTime : CMTimeAdd(lastFrameTime, frameDuration)
                        var pixelBuffer: CVPixelBuffer? = nil
                        let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pixelBufferAdaptor.pixelBufferPool!, &pixelBuffer)
                        if let pixelBuffer = pixelBuffer, status == 0 {
                            let managedPixelBuffer = pixelBuffer
                            CVPixelBufferLockBaseAddress(managedPixelBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
                            let data = CVPixelBufferGetBaseAddress(managedPixelBuffer)
                            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
                            let context = CGContext(data: data, width: Int(outputSize.width), height: Int(outputSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(managedPixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
                            context!.clear(CGRect(x: 0, y: 0, width: CGFloat(outputSize.width), height: CGFloat(outputSize.height)))
                            let horizontalRatio = CGFloat(outputSize.width) / nextPhoto.size.width
                            let verticalRatio = CGFloat(outputSize.height) / nextPhoto.size.height
                            //let aspectRatio = max(horizontalRatio, verticalRatio) // ScaleAspectFill
                            let aspectRatio = min(horizontalRatio, verticalRatio) // ScaleAspectFit
                            let newSize: CGSize = CGSize(width: nextPhoto.size.width * aspectRatio, height: nextPhoto.size.height * aspectRatio)
                            let x = newSize.width < outputSize.width ? (outputSize.width - newSize.width) / 2 : 0
                            let y = newSize.height < outputSize.height ? (outputSize.height - newSize.height) / 2 : 0
                            context?.draw(nextPhoto.cgImage!, in: CGRect(x: x, y: y, width: newSize.width, height: newSize.height))
                            CVPixelBufferUnlockBaseAddress(managedPixelBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
                            appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                        } else {
                            print("Failed to allocate pixel buffer")
                            appendSucceeded = false
                        }
                    }
                    if !appendSucceeded {
                        break
                    }
                    frameCount += 1
                }
                videoWriterInput.markAsFinished()
                videoWriter.finishWriting { () -> Void in
                    print("video url: \(videoURL)")
                    completionHandler(videoURL as URL)
//                    print("-----video1 url = \(self.imageArrayToVideoURL)")
//
//                    self.asset = AVAsset(url: self.imageArrayToVideoURL as URL)
//
//                    let videoUrl : NSURL =  self.imageArrayToVideoURL
//                    let audioUrl : NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "01 The Moment", ofType: "mp3")!)
                    
//                    self.mergeFilesWithUrl(videoUrl: videoUrl as URL, audioUrl: audioUrl as URL)
                }
            })
        }
    }
    
    func mergeMultiVideo() {
        
    }
    
    func createFolder(nameFolder: String) {
        let fileManager = FileManager.default
        
        guard let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        
        let folderPath = documentDirectory.appendingPathComponent(nameFolder, isDirectory: true)
        if fileManager.fileExists(atPath: folderPath.path){
            print("existed")
            do{
                let directoryContent = try fileManager.contentsOfDirectory(atPath: folderPath.path)
                
                for path in directoryContent{
                    let fullPath = folderPath.appendingPathComponent(path)
                    do{
                        try fileManager.removeItem(atPath: fullPath.path)
                    }catch{
                        
                    }
                }
                
            }catch _ as NSError{
                print("error")
            }
            
        }else{
            print("not existing")
            do{
                try fileManager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
                
            }catch let error as NSError{
                print("error create folder: \(error)")
            }
        }
        
    }
    
    func trimVideo(/*videoUrl:URL*/ asset: AVAsset, fileName: String, time: Double, completionHandler: @escaping (URL)->Void) {
        let manager = FileManager.default
        
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        //        guard let mediaType = "mp4" as? String else {return}
        //        guard let url = videoUrl as? NSURL else {return}
        //
        //        let asset = AVAsset(url: url as URL)
        let length = Float(asset.duration.value) / Float(asset.duration.timescale)
        print("video length: \(length) seconds")
        
        let outputURL = documentDirectory.appendingPathComponent("\(fileName).mp4")
        removeFileAtURLIfExists(url: outputURL as NSURL)
        if manager.fileExists(atPath: outputURL.path){
            //code here
            completionHandler(outputURL)
        }else{
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = AVFileType.mp4
            exportSession.shouldOptimizeForNetworkUse = true
            //
            let startTrim = CMTime(seconds: Double(1.0), preferredTimescale: 1000)
            let endTrim = CMTime(seconds: Double(time), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTrim, end: endTrim)
            //
            exportSession.timeRange = timeRange
            //
            exportSession.exportAsynchronously { () -> Void in
                switch exportSession.status {
                    
                case AVAssetExportSessionStatus.completed:
                    //code here
                    completionHandler(outputURL)
                    print("success + \(outputURL)")
                case  AVAssetExportSessionStatus.failed: break
                case AVAssetExportSessionStatus.cancelled: break
                default:
                    print("complete")
                }
            }
        }
    }
    
    func removeFileAtURLIfExists(url: NSURL) {
        if let filePath = url.path {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                do{
                    try fileManager.removeItem(atPath: filePath)
                } catch let error as NSError {
                    print("Couldn't remove existing destination file: \(error)")
                }
            }
        }
    }
}
