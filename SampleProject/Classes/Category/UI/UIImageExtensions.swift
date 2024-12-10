//
//  UIImageExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/6/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import UIKit


// MARK: - Properties
public extension UIImage {

	/// Size in bytes of UIImage
	var bytesSize: Int {
		return self.jpegData(compressionQuality: 1)?.count ?? 0
	}

	/// Size in kilo bytes of UIImage
	var kilobytesSize: Int {
		return bytesSize / 1024
	}

}


// MARK: - Methods
public extension UIImage {

	/// Compressed UIImage from original UIImage.
	///
	/// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
	/// - Returns: optional UIImage (if applicable).
	func compressed(quality: CGFloat = 0.5) -> UIImage? {
		guard let data = compressedData(quality: quality) else {
			return nil
		}
		return UIImage(data: data)
	}

	/// Compressed UIImage data from original UIImage.
	///
	/// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
	/// - Returns: optional Data (if applicable).
	func compressedData(quality: CGFloat = 0.5) -> Data? {
        return self.jpegData(compressionQuality: quality)
	}

	/// UIImage Cropped to CGRect.
	///
	/// - Parameter rect: CGRect to crop UIImage to.
	/// - Returns: cropped UIImage
	func cropped(to rect: CGRect) -> UIImage {
		guard rect.size.height < self.size.height && rect.size.height < self.size.height else {
			return self
		}
		guard let cgImage: CGImage = self.cgImage?.cropping(to: rect) else {
			return self
		}
		return UIImage(cgImage: cgImage)
	}

	/// UIImage scaled to height with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toHeight: new height.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
		let scale = toHeight / self.size.height
		let newWidth = self.size.width * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: toHeight))
		self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// UIImage scaled to width with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toWidth: new width.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, with orientation: UIImage.Orientation? = nil) -> UIImage? {
		let scale = toWidth / self.size.width
		let newHeight = self.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: toWidth, height: newHeight))
		self.draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// UIImage filled with color
	///
	/// - Parameter color: color to fill image with.
	/// - Returns: UIImage filled with given color.
	func filled(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		color.setFill()
		guard let context = UIGraphicsGetCurrentContext() else {
			return self
		}
		context.translateBy(x: 0, y: self.size.height)
		context.scaleBy(x: 1.0, y: -1.0);
		context.setBlendMode(CGBlendMode.normal)

		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
		guard let mask = self.cgImage else {
			return self
		}
		context.clip(to: rect, mask: mask)
		context.fill(rect)

		guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
			return self
		}
		UIGraphicsEndImageContext()
		return newImage
	}

}


// MARK: - Initializers
public extension UIImage {

	/// Create UIImage from color and size.
	///
	/// - Parameters:
	///   - color: image fill color.
	///   - size: image size.
	convenience init(color: UIColor, size: CGSize) {
		UIGraphicsBeginImageContextWithOptions(size, false, 1)
		color.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		self.init(cgImage: image.cgImage!)
	}

}
