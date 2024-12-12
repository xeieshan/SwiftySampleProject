//
//  UIBarButtonItemExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 08/12/2016.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS)

import UIKit


// MARK: - Methods
public extension UIBarButtonItem {

	/// Add Target to UIBarButtonItem
	///
	/// - Parameters:
	///   - target: target.
	///   - action: selector to run when button is tapped.
	func addTargetForAction(target: AnyObject, action: Selector) {
		self.target = target
		self.action = action
	}

}

#endif
