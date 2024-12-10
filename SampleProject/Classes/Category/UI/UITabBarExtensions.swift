//
//  UITabBarExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 9/28/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Methods
public extension UITabBar {
	
	/// Set tabBar colors.
	///
	/// - Parameters:
	///   - background: background color.
	///   - selectedBackground: background color for selected tab.
	///   - item: icon tint color for items.
	///   - selectedItem: icon tint color for item.
	func setColors(background: UIColor? = nil,
	               selectedBackground: UIColor? = nil,
	               item: UIColor? = nil,
	               selectedItem: UIColor? = nil) {
		
		// background
		self.barTintColor = background ?? self.barTintColor
		
		// selectedItem
		self.tintColor = selectedItem ?? self.tintColor
		//		self.shadowImage = UIImage()
		self.backgroundImage = UIImage()
		self.isTranslucent = false
		
		// selectedBackgoundColor
		
		if let selectedbg = selectedBackground {
			let rect = CGSize(width: self.frame.width/CGFloat(self.items!.count), height: self.frame.height)
			self.selectionIndicatorImage = UIImage(color: selectedbg, size: rect)
		}
		
		if let itemColor = item {
			for barItem in self.items! as [UITabBarItem] {
				// item
				if let image = barItem.image {
					barItem.image = image.filled(withColor: itemColor).withRenderingMode(.alwaysOriginal)
                    barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : itemColor], for: .normal)
					if let selected = selectedItem {
                        barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selected], for: .selected)
					}
				}
			}
		}
	}
}

#endif
