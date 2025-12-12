//
//  UIButton+Helpers.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 11/11/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)(void);

@interface UIButton (Helpers)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
