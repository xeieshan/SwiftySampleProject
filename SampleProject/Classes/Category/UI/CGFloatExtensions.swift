//
//  CGFloatExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/23/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import UIKit


// MARK: - Properties
public extension CGFloat {
	
	/// Absolute of CGFloat value.
	public var abs: CGFloat {
		return Swift.abs(self)
	}
	
	/// Ceil of CGFloat value.
	public var ceil: CGFloat {
		return Foundation.ceil(self)
	}
	
	/// Radian value of degree input.
	public var degreesToRadians: CGFloat {
		return CGFloat(M_PI) * self / 180.0
	}
	
	/// Floor of CGFloat value.
	public var floor: CGFloat {
		return Foundation.floor(self)
	}
	
	/// Degree value of radian input.
	public var radiansToDegrees: CGFloat {
		return self * 180 / CGFloat(M_PI)
	}
	
}


// MARK: - Methods
public extension CGFloat {
	
	/// Random CGFloat between two CGFloat values.
	///
	/// - Parameters:
	///   - min: minimum number to start random from.
	///   - max: maximum number random number end before.
	/// - Returns: random CGFloat between two CGFloat values.
	public static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
		let delta = max - min
		return min + CGFloat(arc4random_uniform(UInt32(delta)))
	}
	
}
