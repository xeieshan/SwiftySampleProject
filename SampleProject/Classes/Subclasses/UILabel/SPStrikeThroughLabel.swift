//
//  SPStrikeThroughLabel.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 1/23/17.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import UIKit

class SPStrikeThroughLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    
    func setup() {
        self.text = self.text
        self.textColor = self.textColor
        self.font = self.font
        self.layer.display()

        let attribute = [NSStrikethroughStyleAttributeName: ""]

        let attributedString = NSMutableAttributedString(string: self.text!, attributes: attribute)
        attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, (self.text?.characters.count)!))
        self.attributedText = attributedString
    }
}
