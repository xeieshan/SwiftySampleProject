//
//  UILabelExtension.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 30/04/2017.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation

extension UIFont {
    var isBold: Bool {
        return (fontDescriptor.symbolicTraits.contains(.traitBold))
    }
    
    var isItalic: Bool {
        return (fontDescriptor.symbolicTraits.contains(.traitItalic))
    }
}

extension UILabel {
    
     var defaultFont : UIFont? {

            get { return self.font }
        set {
            if self.font.isBold {
                self.font = UIFont(name: UIConfiguration.UIFONTAPPBOLD, size: self.font.pointSize)
            } else if self.font.isItalic {
                self.font = UIFont(name: UIConfiguration.UIFONTAPPITALIC, size: self.font.pointSize)
            } else {
                self.font = UIFont(name: UIConfiguration.UIFONTAPP, size: self.font.pointSize)
                
            }
        }
    }
//    var defaultFont: UIFont? {
//        get { return self.font }
//        set { self.font = newValue }
//    }
}
