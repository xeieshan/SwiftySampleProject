//
//  UITableView+Helper.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 12/11/2015.
//  Copyright © 2015 <#Project Name#>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITableView (Helper)

- (void)registerClasses:(NSArray *)classes;
- (void)registerCellsWithClasses:(NSArray *)classes;
- (void)removeCellSeparatorOffset;
- (void)removeSeperateIndicatorsForEmptyCells;

@end
