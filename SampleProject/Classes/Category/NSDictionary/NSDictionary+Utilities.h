//
//  NSDictionary+Utilities.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utilities)
- (id)utilities_objectForKeyNotNull:(id)key;
- (id)utilities_objectForKeyWithEmptyString:(id)key;
- (BOOL)utilities_isKindOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)utilities_isMemberOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)utilities_isArrayForKey:(NSString *)key;
- (BOOL)utilities_isDictionaryForKey:(NSString *)key;
- (BOOL)utilities_isStringForKey:(NSString *)key;
- (BOOL)utilities_isNumberForKey:(NSString *)key;

- (NSArray *)utilities_arrayForKey:(NSString *)key;
- (NSDictionary *)utilities_dictionaryForKey:(NSString *)key;
- (NSString *)utilities_stringForKey:(NSString *)key;
- (NSNumber *)utilities_numberForKey:(NSString *)key;
- (double)utilities_doubleForKey:(NSString *)key;
- (float)utilities_floatForKey:(NSString *)key;
- (int)utilities_intForKey:(NSString *)key;
- (unsigned int)utilities_unsignedIntForKey:(NSString *)key;
- (NSInteger)utilities_integerForKey:(NSString *)key;
- (NSUInteger)utilities_unsignedIntegerForKey:(NSString *)key;
- (long long)utilities_longLongForKey:(NSString *)key;
- (unsigned long long)utilities_unsignedLongLongForKey:(NSString *)key;
- (BOOL)utilities_boolForKey:(NSString *)key;
//Extensions
- (BOOL)utilities_existsValue:(NSString*)expectedValue forKey:(NSString*)key;
- (NSInteger)utilities_integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultValue withRange:(NSRange)range;
- (NSInteger)utilities_integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultValue;
- (BOOL)utilities_typeValueForKey:(NSString*)key isArray:(BOOL*)bArray isNull:(BOOL*)bNull isNumber:(BOOL*)bNumber isString:(BOOL*)bString;
- (BOOL)utilities_valueForKeyIsArray:(NSString*)key;
- (BOOL)utilities_valueForKeyIsNull:(NSString*)key;
- (BOOL)utilities_valueForKeyIsString:(NSString*)key;
- (BOOL)utilities_valueForKeyIsNumber:(NSString*)key;
- (BOOL)utilities_containsKey: (NSString *)key;

- (NSDictionary*)utilities_dictionaryWithLowercaseKeys;
+(NSDictionary*)utilities_dictionaryWithContentsOfJSONString:(NSString*)fileLocation;
@end

@interface NSDictionary (Extension)

+ (id)utilities_dictionaryWithArrayOfDictionaries:(NSArray *)array usingKey:(NSString *)key;

- (id)utilities_deepCopy NS_RETURNS_RETAINED;
- (id)utilities_deepMutableCopy NS_RETURNS_RETAINED;

- (id)utilities_nilOrObjectForKey:(id)aKey;
- (id)utilities_emptyStringOrObjectForKey:(id)aKey;

- (BOOL)utilities_hasKey:(id)key;

- (NSArray *)utilities_sortedKeys;

- (BOOL)utilities_boolForKey:(id)key;
- (NSInteger)utilities_integerForKey:(id)key;

- (NSTimeInterval)utilities_timeIntervalForKey:(id)key;

- (NSDate *)utilities_dateForKey:(id)key;
- (NSDate *)utilities_timeForKey:(id)key;

- (NSString *)utilities_descriptionForKey:(id)key;
- (NSInteger)utilities_stringLengthForKey:(id)key;
- (BOOL)utilities_containsSomethingForKey:(id)key;

- (id)utilities_objectForKey:(id)aKey orBool:(BOOL)aDefault;
- (id)utilities_objectForKey:(id)aKey orInteger:(BOOL)aDefault;

- (id)utilities_objectForKey:(id)aKey defaultValue:(id)aDefault;

- (id)utilities_keyForObject:(id)anObject;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableDictionary (Extension)

- (void)utilities_setBool:(BOOL)value forKey:(id)key;
- (void)utilities_setInteger:(NSInteger)value forKey:(id)key;
- (void)utilities_setFloat:(float)value forKey:(id)key;
- (void)utilities_setTimeInterval:(NSTimeInterval)value forKey:(id)key;

- (void)utilities_setDefaultValue:(id)aDefault forKey:(id)aKey;
- (void)utilities_setObject:(id)anObject forKey:(id)aKey defaultValue:(id)aDefault;
- (void)utilities_setObject:(id)anObject forKey:(id)aKey removeIfNil:(BOOL)removeIfNil;

- (void)utilities_replaceObject:(id)oldObject withObject:(id)newObject;

@end

