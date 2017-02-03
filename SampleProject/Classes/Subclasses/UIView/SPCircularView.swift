//
//  SPCircularView.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 01/03/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SPCircularView: UIView {
    
    @IBInspectable
    var color: UIColor = UIColor.red
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        let innerFrame = CGRect(x: 2, y: 2, width: rect.width - 4, height: rect.height - 4)
        context?.setFillColor(color.cgColor)
        context?.addEllipse(in: innerFrame)
        context?.fillPath()
    }
}
