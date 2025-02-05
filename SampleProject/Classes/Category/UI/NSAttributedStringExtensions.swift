//
//  NSAttributedStringExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 26/11/2016.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import UIKit


// MARK: - Properties
public extension NSAttributedString {
	
	#if os(iOS)
	/// Bold string
	var bold: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}
	#endif
	
	/// Underlined string
	var underline: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
		return copy
	}
	
	#if os(iOS)
	/// Italic string
	var italic: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}
	#endif
	
	/// Strikethrough string
	var strikethrough: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
		copy.addAttributes(attributes, range: range)
		return copy
	}
	
}


// MARK: - Methods
public extension NSAttributedString {
	
	/// Add color to NSAttributedString.
	///
	/// - Parameter color: text color.
	/// - Returns: a NSAttributedString colored with given color.
	func colored(with color: UIColor) -> NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
		return copy
	}
	
}


// MARK: - Operators
public extension NSAttributedString {
	
	/// Add a NSAttributedString to another NSAttributedString
	///
	/// - Parameters:
	///   - lhs: NSAttributedString to add to.
	///   - rhs: NSAttributedString to add.
	static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
		let ns = NSMutableAttributedString(attributedString: lhs)
		ns.append(rhs)
		lhs = ns
	}
	
}
