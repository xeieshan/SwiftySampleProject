//
//  UITableViewExtension.swift
//  SampleProject
//
//  Created by Zeeshan Haider on 30/04/2017.
//  Copyright © 2017 XYZco. All rights reserved.
//

import Foundation

extension UITableView {
    func removeCellSeparatorOffset() {
        self.separatorInset = .zero
        
        self.preservesSuperviewLayoutMargins = false
        
        self.layoutMargins = .zero
        
    }
    
    func removeSeperateIndicatorsForEmptyCells() {
        self.tableFooterView = UIView()
    }
}
