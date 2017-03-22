import Foundation

final class ImageManager {

	var text = "Hello, World!"
	var directoryPath: String
	var autoGenerateThumbNails: Bool = false
	var sizes = [CGSize]()
	
	
	/*
	*
	*/
	var DefaultSizes: [String: String]?
	init(with rootDirectoryPath: String, imageDirectory: String = "Images") {
		
		self.directoryPath = rootDirectoryPath
		if imageDirectory.substring(from: imageDirectory.endIndex) != "/" &&
			rootDirectoryPath.substring(to: (rootDirectoryPath.startIndex)) != "/" {
			self.directoryPath.append("/")
		}
		self.directoryPath.append(imageDirectory)
		assert(PathManager.createDirectory(name: self.directoryPath), "Unable to create directory")
	}
	
	func saveImage(image data: NSData, with name: String, generateFolder: Bool) {
		
		let path = self.directoryPath+"/"+name
		assert(PathManager.createDirectory(name: path), "Unable to create directory")
		ThumbImage.saveImage(image: data as! CGImage, url: URL.init(fileURLWithPath:path) as NSURL, and: name, with: "" as CFString, options: nil)
		let s = ThumbImage.scaleImage(image: URL.init(fileURLWithPath:path) as NSURL, by: 0.01)
		print("Image\(s)")
		
	}
	
	
	func resize(image name: String, to size: CGSize)  {
		
	}
	
	func get(image name: String, withSize: CGSize, createifDoesnot exitsts: Bool = true)  {
		
	}
	
}
