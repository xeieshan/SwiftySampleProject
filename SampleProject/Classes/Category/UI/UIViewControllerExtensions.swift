//
//  UIViewControllerExtensions.swift
//  <#Project Name#>
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UIViewController {
	
	/// Check if ViewController is onscreen and not hidden.
	var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}
	
	/// NavigationBar in a ViewController.
//    public var navigationBar: UINavigationBar? {
//        return navigationController?.navigationBar
//    }
	
}

// MARK: - Methods
public extension UIViewController {
	
	/// Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
	func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}
	
	/// Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
	func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}
	
	/// Unassign as listener from all notifications.
	func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
}

#endif
