//
//  UISearchBarExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/23/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UISearchBar {
	
	/// Text field inside search bar (if applicable).
	public var textField: UITextField? {
		let subViews = subviews.flatMap { $0.subviews }
		guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
			return nil
		}
		return textField
	}
	
	/// Text with no spaces or new lines in beginning and end (if applicable).
	public var trimmedText: String? {
		return text?.trimmed
	}
	
}

#endif
