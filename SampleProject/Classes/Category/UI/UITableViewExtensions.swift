//
//  UITableViewExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/22/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS)

import UIKit


// MARK: - Properties
public extension UITableView {
	
	/// Index path of last row in tableView.
	public var indexPathForLastRow: IndexPath? {
		return indexPathForLastRow(inSection: lastSection)
	}
	
	/// Index of last section in tableView.
	public var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// Number of all rows in all sections of tableView.
	public var numberOfRows: Int {
		var section = 0
		var rowCount = 0
		while section < numberOfSections {
			rowCount += numberOfRows(inSection: section)
			section += 1
		}
		return rowCount
	}

}


// MARK: - Methods
public extension UITableView {
	
	/// IndexPath for last row in section.
	///
	/// - Parameter section: section to get last row in.
	/// - Returns: optional last indexPath for last row in section (if applicable).
	public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
		guard section >= 0 else {
			return nil
		}
		guard numberOfRows(inSection: section) > 0  else {
			return IndexPath(row: 0, section: section)
		}
		return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
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
	
	/// Remove TableFooterView.
	public func removeTableFooterView() {
		tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	}
	
	/// Remove TableHeaderView.
	public func removeTableHeaderView() {
		tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	}
	
	
	/// Scroll to bottom of TableView.
	///
	/// - Parameter animated: set true to animate scroll (default is true).
	public func scrollToBottom(animated: Bool = true) {
		let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
		setContentOffset(bottomOffset, animated: animated)
	}
	
	/// Scroll to top of TableView.
	///
	/// - Parameter animated: set true to animate scroll (default is true).
	public func scrollToTop(animated: Bool = true) {
		setContentOffset(CGPoint.zero, animated: animated)
	}
	
}

#endif
