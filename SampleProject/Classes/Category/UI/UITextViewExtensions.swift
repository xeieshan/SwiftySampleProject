//
//  UITextViewExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 9/28/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Methods
public extension UITextView {
	
	/// Scroll to the bottom of text view
	public func scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
	}
	
	/// Scroll to the top of text view
	public func scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
	
}

#endif
