//
//  UINavigationBarExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/22/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Methods
public extension UINavigationBar {
	
	/// Set Navigation Bar title, title color and font.
	///
	/// - Parameters:
	///   - font: title font
	///   - color: title text color (default is .black).
	func setTitleFont(_ font: UIFont, color: UIColor = UIColor.black) {
        titleTextAttributes = [NSAttributedString.Key.font : font ,NSAttributedString.Key.foregroundColor : color ]
	}
	
	/// Make navigation bar transparent.
	///
	/// - Parameter withTint: tint color (default is .white).
	func makeTransparent(withTint: UIColor = .white) {
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
		isTranslucent = true
		tintColor = withTint
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: withTint]
	}
	
	/// Set navigationBar background and text colors
	///
	/// - Parameters:
	///   - background: backgound color
	///   - text: text color
	func setColors(background: UIColor, text: UIColor) {
		self.isTranslucent = false
		self.backgroundColor = background
		self.barTintColor = background
		self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.tintColor = text
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: text]
	}
}

#endif
