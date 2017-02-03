//
//  UICollectionView+Helper.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 12/11/2015.
//  Copyright © 2015 <#Project Name#>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Helper)
- (void)registerCellsWithClasses:(NSArray *)classes;

- (void)registerNibWithClass:(Class)aClass forSupplementaryViewOfKind:(NSString *)kind;
@end
