//
//  UIImageView+Helper.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import "UIImageView+Helper.h"

@implementation UIImageView (Helper)
- (UIImage *) imageWithImageView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}
@end
