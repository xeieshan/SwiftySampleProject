//
//  UITextFieldExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/5/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UITextField {


	/// Check if text field is empty.
	var isEmpty: Bool {
		if let text = self.text {
			return text.isEmpty
		}
		return true
	}
	
	/// Return text with no spaces or new lines in beginning and end.
	var trimmedText: String? {
		return text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	@IBInspectable
	/// Left view tint color.
	var leftViewTintColor: UIColor? {
		get {
			guard let iconView = self.leftView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = self.leftView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}
	
	@IBInspectable
	/// Right view tint color.
	var rightViewTintColor: UIColor? {
		get {
			guard let iconView = self.rightView as? UIImageView else {
				return nil
			}
			return iconView.tintColor
		}
		set {
			guard let iconView = self.rightView as? UIImageView else {
				return
			}
			iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
			iconView.tintColor = newValue
		}
	}
}


// MARK: - Methods
public extension UITextField {
	
	/// Set placeholder text color.
	///
	/// - Parameter color: placeholder text color.
	func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
	}
	
}

#endif
