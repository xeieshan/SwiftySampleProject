//
//  UISegmentedControlExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 9/28/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UISegmentedControl {
	
	/// Segments titles.
	public var segmentTitles: [String?] {
		get {
			var titles: [String?] = []
			var i = 0
			while i < numberOfSegments {
				titles.append(titleForSegment(at: i))
				i += 1
			}
			return titles
		}
		set {
			removeAllSegments()
			for (index, title) in newValue.enumerated() {
				insertSegment(withTitle: title, at: index, animated: false)
			}
		}
	}
	
	/// Segments images.
	public var segmentImages: [UIImage?] {
		get {
			var images: [UIImage?] = []
			var i = 0
			while i < numberOfSegments {
				images.append(imageForSegment(at: i))
				i += 1
			}
			return images
		}
		set {
			removeAllSegments()
			for (index, image) in newValue.enumerated() {
				insertSegment(with: image, at: index, animated: false)
			}
		}
	}
	
}

#endif
