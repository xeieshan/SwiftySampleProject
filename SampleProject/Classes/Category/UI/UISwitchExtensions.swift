//
//  UISwitchExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 08/12/2016.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS)

import UIKit

// MARK: - Methods
public extension UISwitch {
	
	/// Toggle a UISwitch
	///
	/// - Parameter animated: set true to animate the change (default is true)
	func toggle(animated: Bool = true) {
		setOn(!isOn, animated: animated)
	}
}

#endif
