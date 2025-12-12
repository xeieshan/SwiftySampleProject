//
//  UICollectionViewExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 11/12/2016.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UICollectionView {
	
	/// Index path of last item in collectionView.
	var indexPathForLastItem: IndexPath? {
		return indexPathForLastItem(inSection: lastSection)
	}
	
	/// Index of last section in collectionView.
	var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// Number of all items in all sections of collectionView.
	var numberOfItems: Int {
		var section = 0
		var itemsCount = 0
		while section < self.numberOfSections {
			itemsCount += numberOfItems(inSection: section)
			section += 1
		}
		return itemsCount
	}
	
}


// MARK: - Methods
public extension UICollectionView {
	
	/// IndexPath for last item in section.
	///
	/// - Parameter section: section to get last item in.
	/// - Returns: optional last indexPath for last item in section (if applicable).
	func indexPathForLastItem(inSection section: Int) -> IndexPath? {
		guard section >= 0 else {
			return nil
		}
		guard numberOfItems(inSection: section) > 0 else {
			return IndexPath(item: 0, section: section)
		}
		return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
	}
	
	/// Reload data with a completion handler.
	///
	/// - Parameter completion: completion handler to run after reloadData finishes.
	func reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}
}

#endif
