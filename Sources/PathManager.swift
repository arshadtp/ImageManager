	//
//  PathManager.swift
//  ImageManager
//
//  Created by Arshad T P on 3/17/17.
//
//

import Foundation

final class PathManager {
	
	internal static func createDirectory(name: String) -> Bool {
		
		do {
			try FileManager.default.createDirectory(atPath: name, withIntermediateDirectories: true, attributes: nil)
			return true
		} catch {
			assert((!error.localizedDescription.isEmpty), error as! String)
			print(error)
			return false
		}
	}
}
