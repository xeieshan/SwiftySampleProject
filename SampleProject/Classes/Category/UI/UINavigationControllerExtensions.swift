//
//  UINavigationControllerExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/6/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Methods
public extension UINavigationController {
	
	///  Pop ViewController with completion handler.
	///
	/// - Parameter completion: optional completion handler (default is nil).
	func popViewController(completion: (()->Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: true)
		CATransaction.commit()
	}
	
	/// Push ViewController with completion handler.
	///
	/// - Parameters:
	///   - viewController: viewController to push.
	/// - Parameter completion: optional completion handler (default is nil).
	func pushViewController(viewController: UIViewController, completion: (()->Void)? = nil)  {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}
	
	/// Make navigation controller's navigation bar transparent.
	///
	/// - Parameter withTint: tint color (default is .white).
	func makeTransparent(withTint: UIColor = .white) {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		navigationBar.tintColor = withTint
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: withTint]
	}
	
}

#endif
