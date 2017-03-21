//
//  ABThumbImage.swift
//  ImageProcess
//
//  Created by Arshad T P on 3/15/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

import Foundation
import ImageIO

final class ThumbImage {
	
	class func scaleImage(image url:NSURL, by factor: Float) -> CGImage?  {
		
		if let imageSource = CGImageSourceCreateWithURL(url, nil) {
			
			let count  = CGImageSourceGetCount(imageSource)
			print("image count == \(count)")
			
			let imageSize = self.getImageSizeFromSource(image: imageSource)
			let options: [NSString: NSObject] = [
				kCGImageSourceThumbnailMaxPixelSize: NSNumber.init(value: Float(max(imageSize.height, imageSize.width))*factor),
				kCGImageSourceCreateThumbnailFromImageIfAbsent: kCFBooleanTrue,
				kCGImageSourceCreateThumbnailFromImageAlways: kCFBooleanFalse
			]
			let scaleImageMap = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary?)
			let scaledImage = scaleImageMap.flatMap {  $0 }
			
			self.saveImage(image: scaleImageMap!, url: url, and: self.generateName(for: imageSize, with: url.lastPathComponent!), with: kUTTypeTIFF, options: nil)
			return scaledImage
		}
		return nil
	}
	
	static func saveImage(image: CGImage, url: NSURL, and name:String, with type: CFString, options: CFDictionary?)  {
		
		var newFilePath = url.deletingLastPathComponent
		newFilePath?.appendPathComponent(name)
		let myImageDest = CGImageDestinationCreateWithURL(newFilePath as! CFURL, type, 0, nil)
		CGImageDestinationAddImage(myImageDest!, image, nil)
		CGImageDestinationFinalize(myImageDest!)
	}

	
	internal static func generateName(for size: CGSize, with orignalName: String ) -> String {
		
		let nameComponets = orignalName.components(separatedBy: ".")
		var fileName = ""
		if nameComponets.count > 0	{
			fileName = orignalName +  "\(size.width)" + "X" + "\(size.height)"
		}
		if nameComponets.count > 1 {
			fileName.append(".\(nameComponets[1])")
		}
		return fileName
	}

	internal class func getImageSizeFromSource(image imageSource: CGImageSource)  -> CGSize {
		
		let options: [NSString: NSObject] = [kCGImageSourceShouldCache: kCFBooleanTrue]
		if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, options as CFDictionary?) {
			
			let metaData = imageProperties as NSDictionary
			let width = metaData.value(forKey: kCGImagePropertyPixelWidth as String)
			let height = metaData.value(forKey: kCGImagePropertyPixelHeight as String)
			
			return CGSize.init(width: width as! Int, height: height as! Int)
		}
		
		return CGSize.zero
	}
	
	internal class func getImageSize(image url: NSURL)  -> CGSize {
		
		let imageSource = CGImageSourceCreateWithURL(url, nil)
		if  imageSource != nil {
			return self.getImageSizeFromSource(image: imageSource!)
		}
		return CGSize.zero
	}

	
}
