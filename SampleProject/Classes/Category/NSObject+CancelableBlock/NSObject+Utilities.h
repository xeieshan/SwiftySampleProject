//
//  NSObject+Utilities.h


#import <Foundation/Foundation.h>

@interface NSObject (Utilities)

- (void)utilities_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (void)utilities_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay cancelPreviousRequest:(BOOL)cancel;

@end



@interface NSObject (Extension)

- (id)utilities_valueForKeyPath:(NSString *)keyPath defaultValue:(id)defaultValue;

- (void)utilities_setValueForKey:(NSString *)key withDictionary:(NSDictionary *)dict;
- (void)utilities_setValueForKey:(NSString *)key orDictKey:(NSString *)altKey withDictionary:(NSDictionary *)dict;
- (void)utilities_setValueForKey:(NSString *)key orDictKeys:(NSArray *)altKeys withDictionary:(NSDictionary *)dict;

- (void)utilities_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key;
- (void)utilities_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key removeIfNil:(BOOL)removeIfNil;

- (BOOL)utilities_isReallySubclassOfClass:(Class)aClass;

- (BOOL)utilities_isEquivalent:(id)anObject;
- (BOOL)utilities_isEquivalentTo:(id)anObject;

- (BOOL)utilities_performBoolSelector:(SEL)selector;
- (BOOL)utilities_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
- (BOOL)utilities_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;

- (NSInteger)utilities_performIntegerSelector:(SEL)selector;
- (NSInteger)utilities_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
- (NSInteger)utilities_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;

- (void)utilities_performSelector:(SEL)selector withArguments:(NSArray *)arguments;

- (void)utilities_performSelector:(SEL)selector withEachObjectInArray:(NSArray *)array;
- (void)utilities_performSelector:(SEL)selector withEachObjectInDictionary:(NSDictionary *)dict;
- (void)utilities_performSelector:(SEL)selector withEachObjectInSet:(NSSet *)set;

@end

