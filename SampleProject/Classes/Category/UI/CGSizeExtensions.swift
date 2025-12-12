//
//  CGSizeExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/22/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import UIKit


// MARK: - Methods
public extension CGSize {
	
	/// Aspect fit CGSize.
	///
	/// - Parameter boundingSize: bounding size to fit self to.
	/// - Returns: self fitted into given bounding size
	func aspectFit(to boundingSize: CGSize) -> CGSize {
		let minRatio = min(boundingSize.width / width, boundingSize.height / height)
		return CGSize(width: width * minRatio, height: height * minRatio)
	}
	
	/// Aspect fill CGSize.
	///
	/// - Parameter boundingSize: bounding size to fill self to.
	/// - Returns: self filled into given bounding size
	func aspectFill(to boundingSize: CGSize) -> CGSize {
		let minRatio = max(boundingSize.width / width, boundingSize.height / height)
		return CGSize(width: width * minRatio, height: height * minRatio)
	}
	
}
