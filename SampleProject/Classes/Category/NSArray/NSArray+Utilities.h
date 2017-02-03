#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface NSMutableArray (Utilities)


#pragma mark -
#pragma mark Instance Methods

-(NSArray*)utilities_arrayByRemovingObject:(id)obj;
-(id)utilities_safeObjectAtIndex:(NSUInteger)index ;
-(id)utilities_randomObject;
- (NSMutableArray*)utilities_shuffle;

@end // @interface NSArray (Accessing)


@interface NSArray (Extension)

- (BOOL)utilities_isValidIndex:(NSUInteger)i;

- (id)utilities_objectMatching:(id)match usingKey:(NSString *)key;
- (NSUInteger)utilities_indexOfObjectMatching:(id)match usingKey:(NSString *)key;

- (id)utilities_objectMatching:(id)match usingSelector:(SEL)selector;
- (id)utilities_objectMatching:(id)match orDefault:(id)defaultMatch orFirst:(BOOL)firstIfNotFound usingSelector:(SEL)selector;

- (NSArray *)utilities_arrayWithObjectsMatching:(id)match usingKey:(NSString *)key;
- (NSArray *)utilities_arrayWithObjectsMatching:(id)match usingSelector:(SEL)selector;

- (NSArray *)utilities_arrayUsingSelector:(SEL)selector;

- (NSArray *)utilities_arrayByRemovingObject:(id)object;
- (NSArray *)utilities_arrayByRemovingObjectAtIndex:(NSUInteger)idx;
- (NSArray *)utilities_arrayByRemovingObjectsInArray:(NSArray *)otherArray;

- (NSArray *)utilities_reverseArray;

- (NSArray *)utilities_sortedArrayUsingFinderOrder;
- (NSArray *)utilities_sortedArrayUsingKey:(NSString *)key ascending:(BOOL)ascending;

- (BOOL)utilities_containsObjectIdenticalTo:(id)obj;
- (BOOL)utilities_containsObjectEquivalentTo:(id)obj;
- (NSUInteger)utilities_indexOfObjectEquivalentTo:(id)obj;

- (id)utilities_objectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

- (id)utilities_penultimateObject;

- (id)utilities_deepCopy NS_RETURNS_RETAINED;
- (id)utilities_deepMutableCopy NS_RETURNS_RETAINED;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableArray (Extension)

- (NSUInteger)utilities_insertObject:(id)object atIndex:(NSUInteger)i orEnd:(BOOL)atEnd;
- (void)utilities_insertObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i;
- (NSUInteger)utilities_insertOrMoveObjectsFromArray:(NSArray *)array atIndex:(NSUInteger)i;
- (void)utilities_addOrMoveObjectsFromArray:(NSArray *)array;

- (NSMutableArray *)utilities_arrayWithIndexEnumerator:(NSEnumerator *)enumerator;

- (void)utilities_removeObjectsFromIndexEnumerator:(NSEnumerator *)enumerator;
- (void)utilities_removeObjectsMatching:(id)match usingKey:(NSString *)key;

- (NSMutableArray *)utilities_reverseArray;

- (void)utilities_makeObjectsSafelyPerformSelector:(SEL)selector;

- (void)utilities_enqueue:(id)obj;
- (id)utilities_dequeue;

- (void)utilities_push:(id)obj;
- (id)utilities_pop;

@end
