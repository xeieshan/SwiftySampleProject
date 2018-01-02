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
	public var bold: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}
	#endif
	
	/// Underlined string
	public var underline: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue], range: range)
		return copy
	}
	
	#if os(iOS)
	/// Italic string
	public var italic: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
		return copy
	}
	#endif
	
	/// Strikethrough string
	public var strikethrough: NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
		let attributes = [
            NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)]
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
	public func colored(with color: UIColor) -> NSAttributedString {
		guard let copy = self.mutableCopy() as? NSMutableAttributedString else {
			return self
		}
		let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedStringKey.foregroundColor: color], range: range)
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
	public static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
		let ns = NSMutableAttributedString(attributedString: lhs)
		ns.append(rhs)
		lhs = ns
	}
	
}
