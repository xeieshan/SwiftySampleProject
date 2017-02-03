//
//  TextSegment
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 22/01/2017.
//  Copyright © 2017 <#Project Developer#> All rights reserved.
//

import UIKit

public class OCTextSegment: NSObject, SPSegmentContentProtocol {
    
    public var text: String!
    public var otherAttr: String!
    
    public var type: SPSegmentType {
        return SPSegmentType.text(text)
    }
    
    public init(text: String, otherAttr: String = "") {
        super.init()
        
        self.text = text
        self.otherAttr = otherAttr
    }
}

public class OCIconSegment: NSObject, SPSegmentContentProtocol {
    
    public var icon: UIImage!
    
    public var type: SPSegmentType {
        return SPSegmentType.icon(icon)
    }
    
    public init(icon: UIImage) {
        super.init()
        
        self.icon = icon
    }
}
