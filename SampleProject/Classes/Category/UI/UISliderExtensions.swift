//
//  UISliderExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 9/28/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS)

import UIKit

// MARK: - Methods
public extension UISlider {
	
	/// Set slide bar value with completion handler.
	///
	/// - Parameters:
	///   - value: slider value.
	///   - animated: set true to animate value change (default is true).
	///   - duration: animation duration in seconds (default is 1 second).
	///   - completion: an optional completion handler to run after value is changed (default is nil)
	func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, animations: {
				self.setValue(value, animated: true)
			}, completion: { finished in
				completion?()
			})
		} else {
			setValue(value, animated: false)
			completion?()
		}
	}
	
}
	
#endif
