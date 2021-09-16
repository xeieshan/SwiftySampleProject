//
//  SPCentredTableView.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import UIKit
class SPCentredTableView: UITableView {

    override func reloadData() {
        super.reloadData()
        self.centerTableViewContentsIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerTableViewContentsIfNeeded()
    }

    func centerTableViewContentsIfNeeded() {
        let totalHeight: CGFloat = self.bounds.height
        let contentHeight: CGFloat = self.contentSize.height
            //If we have less content than our table frame then we can center
        let contentCanBeCentered: Bool = contentHeight < totalHeight
        if contentCanBeCentered {
            self.contentInset = UIEdgeInsets(top: ceil(totalHeight / 2.0 - contentHeight / 2.0), left: 0, bottom: 0, right: 0)
        }
        else {
            self.contentInset = UIEdgeInsets.zero
        }
    }
}
