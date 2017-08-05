//
//  SPOvalButton.swift
//  SampleProject
//
//  Created by Zeeshan Haider on 05/08/2017.
//  Copyright © 2017 XYZco. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SPOvalButton : UIButton {
    @IBInspectable var cornerRadiusValue: CGFloat = 8{
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.setNeedsDisplay()
        self.backgroundColor = UIConfiguration.appColor
        
    }
    
}
