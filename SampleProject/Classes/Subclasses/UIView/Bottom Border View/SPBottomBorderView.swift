//
//  SPBottomBorderView.swift
//  SampleProject
//
//  Created by Zeeshan Haider on 05/08/2017.
//  Copyright © 2017 XYZco. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SPBottomBorderView : UIView {
    fileprivate var bottomStokeView : UIView = UIView()
    @IBInspectable var bottomBarColor: UIColor = UIColor.white
    
    override func awakeFromNib() {
        bottomStokeView.translatesAutoresizingMaskIntoConstraints = false
        bottomStokeView.backgroundColor = bottomBarColor
        self.addSubview(bottomStokeView)
        
        if #available(iOS 9.0, *) {
            // use the feature only available in iOS 9
            // Configure Constraints
            bottomStokeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
            bottomStokeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
            bottomStokeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
            bottomStokeView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layoutIfNeeded()
    }
}
