//
//  SPShadowView.swift
//  SampleProject
//
//  Created by Zeeshan Haider on 05/08/2017.
//  Copyright © 2017 XYZco. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SPShadowView: UIView {
    
    /**
     Masks the layer to it's bounds and updates the layer properties and shadow path.
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = false
        
        self.updateProperties()
        self.updateShadowPath()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = false
        
        self.updateProperties()
        self.updateShadowPath()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.updateProperties()
        self.updateShadowPath()
    }
    /**
     Updates all layer properties according to the public properties of the `ShadowView`.
     */
    public func updateProperties() {
        //        self.layer.cornerRadius = UIConfiguration.Shadow.cornerRadius
        self.layer.shadowColor = UIConfiguration.Shadow.shadowColor.cgColor
        self.layer.shadowOffset = UIConfiguration.Shadow.shadowOffset
        self.layer.shadowRadius = UIConfiguration.Shadow.shadowRadius
        self.layer.shadowOpacity = UIConfiguration.Shadow.shadowOpacity
    }
    
    /**
     Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
     */
    public func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: UIConfiguration.Shadow.cornerRadius).cgPath
    }
    
    /**
     Updates the shadow path everytime the views frame changes.
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateShadowPath()
    }
}
