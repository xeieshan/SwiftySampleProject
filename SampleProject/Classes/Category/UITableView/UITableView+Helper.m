//
//  UITableView+Helper.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 12/11/2015.
//  Copyright © 2015 <#Project Name#>. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

- (void)registerClasses:(NSArray *)classes {
    for (Class aClass in classes) {
        NSString *className = NSStringFromClass(aClass);
        [self registerClass:aClass forCellReuseIdentifier:className];
    }
}

- (void)registerCellsWithClasses:(NSArray *)classes {
    for (Class aClass in classes) {
        NSString *className = NSStringFromClass(aClass);
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
        if (nibPath) {
            UINib *nib = [UINib nibWithNibName:className bundle:nil];
            [self registerNib:nib forCellReuseIdentifier:className];
        } else {
            [self registerClass:aClass forCellReuseIdentifier:className];
        }
    }
}
- (void)removeCellSeparatorOffset
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
        [self setSeparatorInset:UIEdgeInsetsZero];
    
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [self setPreservesSuperviewLayoutMargins:NO];
    
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
        [self setLayoutMargins:UIEdgeInsetsZero];
}
- (void)removeSeperateIndicatorsForEmptyCells
{
    [self setTableFooterView:[UIView new]];
}

@end
