import Foundation

final class ImageManager {

	var text = "Hello, World!"
	var directoryPath: String
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
		
		assert(PathManager.createDirectory(name: self.directoryPath+"/"+name), "Unable to create directory")
		ThumbImage.saveImage(image: data as! CGImage, url: URL.init(fileURLWithPath: self.directoryPath+"/"+name) as NSURL, and: name, with: "" as CFString, options: nil)
		
	}
	
	
	func resize(image name: String, to size: CGSize)  {
		
	}
	
	func get(image name: String, withSize: CGSize, createifDoesnot exitsts: Bool = true)  {
		
	}
	
}
