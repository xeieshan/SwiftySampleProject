//
//  UIImageViewExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/25/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Methods
extension UIImageView {

	

	/// Make image view blurry
	///
	/// - Parameter withStyle: UIBlurEffectStyle (default is .light).
    func blur(withStyle: UIBlurEffect.Style = .light) {
		let blurEffect = UIBlurEffect(style: withStyle)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
		self.clipsToBounds = true
	}

	/// Blurred version of an image view
	///
	/// - Parameter withStyle: UIBlurEffectStyle (default is .light).
	/// - Returns: blurred version of self.
    func blurred(withStyle: UIBlurEffect.Style = .light) -> UIImageView {
		return self.blurred(withStyle: withStyle)
	}

}

#endif
