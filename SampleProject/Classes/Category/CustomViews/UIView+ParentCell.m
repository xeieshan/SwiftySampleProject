//
//  UIView+ParentCell.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/16/13.
//  Copyright (c) 2013 <#Project Name#>. All rights reserved.
//

#import "UIView+ParentCell.h"

@implementation UIView (ParentCell)

- (UITableViewCell *)parentCell
{
    UIView *superview = self.superview;
    while( superview != nil ) {
        if( [superview isKindOfClass:[UITableViewCell class]] )
            return (UITableViewCell *)superview;
        
        superview = superview.superview;
    }
    
    return nil;
}

@end
