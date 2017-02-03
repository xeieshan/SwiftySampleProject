//
//  UICollectionView+Helper.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 12/11/2015.
//  Copyright © 2015 <#Project Name#>. All rights reserved.
//

#import "UICollectionView+Helper.h"

@implementation UICollectionView (Helper)
- (void)registerCellsWithClasses:(NSArray *)classes {
    for (Class aClass in classes) {
        NSString *className = NSStringFromClass(aClass);
        NSString *pathString = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
        if (pathString) {
            UINib *nib = [UINib nibWithNibName:className bundle:nil];
            [self registerNib:nib forCellWithReuseIdentifier:className];
        } else {
            [self registerClass:aClass forCellWithReuseIdentifier:className];
        }
        
    }
}

- (void)registerNibWithClass:(Class)aClass forSupplementaryViewOfKind:(NSString *)kind {
    NSString *className = NSStringFromClass([aClass class]);
    NSString *pathString = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
    
    if (pathString) {
        [self registerNib:[UINib nibWithNibName:className bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:className];
    } else {
        [self registerClass:aClass forSupplementaryViewOfKind:kind withReuseIdentifier:className];
    }
    
}
@end
