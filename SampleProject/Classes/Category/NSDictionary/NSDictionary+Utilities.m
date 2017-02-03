//
//  NSDictionary+Utilities.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import "NSDictionary+Utilities.h"
#import <math.h>
#import "NSDate+Utilities.h"

@implementation NSDictionary (Utilities)
// in case of [NSNull null] values a nil is returned ...
- (id)utilities_objectForKeyNotNull:(id)key
{
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return @"";
    
    return object;
}

// if objectForKey returns nil, it will
// return an empty string.
- (id)utilities_objectForKeyWithEmptyString:(id)key
{
    id object = [self utilities_objectForKeyNotNull:key];
    if (object == nil)
    {
        return @"";
    }
    return object;
}
- (BOOL)utilities_isKindOfClass:(Class)aClass forKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass];
}

- (BOOL)utilities_isMemberOfClass:(Class)aClass forKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [value isMemberOfClass:aClass];
}

- (BOOL)utilities_isArrayForKey:(NSString *)key
{
    return [self utilities_isKindOfClass:[NSArray class] forKey:key];
}

- (BOOL)utilities_isDictionaryForKey:(NSString *)key
{
    return [self utilities_isKindOfClass:[NSDictionary class] forKey:key];
}

- (BOOL)utilities_isStringForKey:(NSString *)key
{
    return [self utilities_isKindOfClass:[NSString class] forKey:key];
}

- (BOOL)utilities_isNumberForKey:(NSString *)key
{
    return [self utilities_isKindOfClass:[NSNumber class] forKey:key];
}

- (NSArray *)utilities_arrayForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)utilities_dictionaryForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)utilities_stringForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(description)]) {
        return [value description];
    }
    return nil;
}

- (NSNumber *)utilities_numberForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        return [nf numberFromString:value];
    }
    return nil;
}

- (double)utilities_doubleForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (float)utilities_floatForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0;
}

- (int)utilities_intForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value intValue];
    }
    return 0;
}

- (unsigned int)utilities_unsignedIntForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }
    return 0;
}

- (NSInteger)utilities_integerForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)utilities_unsignedIntegerForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (long long)utilities_longLongForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)utilities_unsignedLongLongForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (BOOL)utilities_boolForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return NO;
}


- (BOOL)utilities_existsValue:(NSString*)expectedValue forKey:(NSString*)key {
    id val = [self valueForKey:key];
    BOOL exists = false;
    
    if (val != nil) {
        exists = [(NSString*)val compare : expectedValue options : NSCaseInsensitiveSearch] == 0;
    }
    
    return exists;
}
- (BOOL)utilities_containsKey: (NSString *)key {
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}
- (NSInteger)utilities_integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultValue withRange:(NSRange)range
{
    NSInteger value = defaultValue;
    
    NSNumber* val = [self valueForKey:key];  // value is an NSNumber
    
    if (val != nil) {
        value = [val integerValue];
    }
    
    // min, max checks
    value = MAX(range.location, value);
    value = MIN(range.length, value);
    
    return value;
}

- (NSInteger)utilities_integerValueForKey:(NSString*)key defaultValue:(NSInteger)defaultValue
{
    NSInteger value = defaultValue;
    
    NSNumber* val = [self valueForKey:key];  // value is an NSNumber
    
    if (val != nil) {
        value = [val integerValue];
    }
    return value;
}

/*
 *	Determine the type of object stored in a dictionary
 *	IN:
 *	(BOOL*) bString - if exists will be set to YES if object is an NSString, NO if not
 *	(BOOL*) bNull - if exists will be set to YES if object is an NSNull, NO if not
 *	(BOOL*) bArray - if exists will be set to YES if object is an NSArray, NO if not
 *	(BOOL*) bNumber - if exists will be set to YES if object is an NSNumber, NO if not
 *
 *	OUT:
 *	YES if key exists
 *  NO if key does not exist.  Input parameters remain untouched
 *
 */

- (BOOL)utilities_typeValueForKey:(NSString*)key isArray:(BOOL*)bArray isNull:(BOOL*)bNull isNumber:(BOOL*)bNumber isString:(BOOL*)bString
{
    BOOL bExists = YES;
    NSObject* value = [self objectForKey:key];
    
    if (value) {
        bExists = YES;
        if (bString) {
            *bString = [value isKindOfClass:[NSString class]];
        }
        if (bNull) {
            *bNull = [value isKindOfClass:[NSNull class]];
        }
        if (bArray) {
            *bArray = [value isKindOfClass:[NSArray class]];
        }
        if (bNumber) {
            *bNumber = [value isKindOfClass:[NSNumber class]];
        }
    }
    return bExists;
}

- (BOOL)utilities_valueForKeyIsArray:(NSString*)key
{
    BOOL bArray = NO;
    NSObject* value = [self objectForKey:key];
    
    if (value) {
        bArray = [value isKindOfClass:[NSArray class]];
    }
    return bArray;
}

- (BOOL)utilities_valueForKeyIsNull:(NSString*)key
{
    BOOL bNull = NO;
    NSObject* value = [self objectForKey:key];
    
    if (value) {
        bNull = [value isKindOfClass:[NSNull class]];
    }
    return bNull;
}

- (BOOL)utilities_valueForKeyIsString:(NSString*)key
{
    BOOL bString = NO;
    NSObject* value = [self objectForKey:key];
    
    if (value) {
        bString = [value isKindOfClass:[NSString class]];
    }
    return bString;
}

- (BOOL)utilities_valueForKeyIsNumber:(NSString*)key
{
    BOOL bNumber = NO;
    NSObject* value = [self objectForKey:key];
    
    if (value) {
        bNumber = [value isKindOfClass:[NSNumber class]];
    }
    return bNumber;
}

- (NSDictionary*)utilities_dictionaryWithLowercaseKeys
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    NSString* key;
    
    for (key in self) {
        [result setObject:[self objectForKey:key] forKey:[key lowercaseString]];
    }
    
    return result;
}
+(NSDictionary*)utilities_dictionaryWithContentsOfJSONString:(NSString*)fileLocation
{
    NSString *string = fileLocation;

    NSString *filePath = [[NSBundle bundleWithPath:string] pathForResource:@"Data" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}
@end


@implementation NSDictionary (Extension)

/**
 Given an array that contains dictionaries, and a key that is used in those dictionaries, returns a new dictionary that has the values of those keys as the keys, and the dictionaries as the values.  Returns nil if the array or key parameters are nil.  Effectively the reverse of the -allValues method.
 
 @author DJS 2004-06.
 */

+ (id)utilities_dictionaryWithArrayOfDictionaries:(NSArray *)array usingKey:(NSString *)key;
{
    if (!array || !key)
        return nil;
    
    NSMutableDictionary *masterDict = [NSMutableDictionary dictionaryWithCapacity:[array count]];
    NSDictionary *subDict;
    
    for (subDict in array)
    {
        NSString *identifier = subDict[key];
        
        if (identifier)
            masterDict[identifier] = subDict;
    }
    
    return masterDict;
}

/**
 Similar to -copy, but each of the objects in the dictionary are copied too (using the same keys).  Note that like -copy, the dictionary is retained.
 
 @author DJS 2004-06.
 @version DJS 2006-01: changed to fix memory leak through excessive retaining.
 @version DJS 2009-01: changed to use fast enumeration.
 */

- (id)utilities_deepCopy;
{
    id dict = [NSMutableDictionary new];
    id copy;
    
    for (id key in self)
    {
        id object = self[key];
        
        if ([object respondsToSelector:@selector(utilities_deepCopy)])
            copy = [object utilities_deepCopy];
        else
            copy = [object copy];
        
        dict[key] = copy;
    }
    
    return dict;
}

/**
 Similar to -utilities_deepCopy, above, but makes all of the contents of the dictionary mutable.
 
 @author DJS 2009-01.
 */

- (id)utilities_deepMutableCopy;
{
    id dict = [NSMutableDictionary new];
    id mutableCopy;
    
    for (id key in self)
    {
        id object = self[key];
        
        if ([object respondsToSelector:@selector(utilities_deepMutableCopy)])
            mutableCopy = [object utilities_deepMutableCopy];
        else if ([object conformsToProtocol:@protocol(NSMutableCopying)])
            mutableCopy = [object mutableCopy];
        else
            mutableCopy = [object copy];
        
        dict[key] = mutableCopy;
    }
    
    return dict;
}

/**
 Returns an entry's value given its key, or nil if no value is associated with aKey, or it is NSNull.
 
 @author DJS 2012-05.
 */

- (id)utilities_nilOrObjectForKey:(id)aKey;
{
    id value = self[aKey];
    
    if ([value isKindOfClass:[NSNull class]])
        value = nil;
    
    return value;
}

/**
 Returns an entry's value given its key, or an empty string (@"") if no value is associated with aKey, or it is NSNull.
 
 @author DJS 2004-01.
 @version DJS 2012-05: changed to return an empty string instead of NSNull.
 */

- (id)utilities_emptyStringOrObjectForKey:(id)aKey;
{
    id value = self[aKey];
    
    if (!value || [value isKindOfClass:[NSNull class]])
        value = @"";
    
    return value;
}

/**
 Returns YES if the key exists in the dictionary, or NO if it doesn't.  Dubious benefit, since -objectForKey:'s result can be treated as a boolean anyway, but sometimes you want an actual BOOL value.
 
 @author DJS 2005-02.
 */

- (BOOL)utilities_hasKey:(id)key;
{
    return (self[key] != nil);
}

/**
 Like -allKeys, but sorted in ascending alphabetical order by the dictionary's keys (not case sensitive).
 
 @author DJS 2006-09.
 */

- (NSArray *)utilities_sortedKeys;
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

// NOTE: may want to add -arrayForKey:, -mutableArrayForKey:, and other variations too sometime.

/**
 Returns YES if the value for this key is a string containing "yes" (case insensitive), or a number with a non-zero value.  Otherwise returns NO.
 
 @author DJS 2005-02.
 */

- (BOOL)utilities_boolForKey:(id)key;
{
    NSString *value = [self utilities_descriptionForKey:key];
    
    if (value)
        return ([value integerValue] || [[value lowercaseString] isEqualToString:@"yes"]);
    else
        return NO;
}

/**
 Invokes descriptionForKey: with the key.  Returns 0 if no string is returned.  Otherwise, the resulting string is sent an integerValue message, which provides this method's return value.
 
 @author DJS 2005-02.
 */

- (NSInteger)utilities_integerForKey:(id)key;
{
    NSString *value = [self utilities_descriptionForKey:key];
    
    if (value)
        return [value integerValue];
    else
        return 0;
}

/**
 Invokes descriptionForKey: with the key.  Returns 0.0 if no string is returned.  Otherwise, the resulting string is sent a floatValue message, which provides this method's return value.
 
 @author DJS 2005-02.
 */


/**
 Invokes descriptionForKey: with the key.  Returns 0.0 if no string is returned.  Otherwise, the resulting string is sent a doubleValue message, which provides this method's return value.
 
 @author DJS 2005-02.
 */

- (NSTimeInterval)utilities_timeIntervalForKey:(id)key
{
    NSString *value = [self utilities_descriptionForKey:key];
    
    if (value)
        return [value doubleValue];
    else
        return 0.0;
}

/**
 Returns a date from a JSON string, or nil if NSNull or not a valid date.
 
 @author DJS 2012-07.
 */

- (NSDate *)utilities_dateForKey:(id)key;
{
    return [NSDate utilities_dateWithJSONString:[self utilities_nilOrObjectForKey:key] allowPlaceholder:NO];
}

/**
 Returns a time from a JSON string, or nil if NSNull or not a valid time.
 
 @author DJS 2012-07.
 */

- (NSDate *)utilities_timeForKey:(id)key;
{
    return [NSDate utilities_dateWithJSONString:[self utilities_nilOrObjectForKey:key] allowPlaceholder:YES];
}

/**
 Like -objectForKey:, but always returns a string, or nil if there is no object with that key.  Uses -description to convert any non-string types to a string equivalent.
 
 @author DJS 2005-02.
 @version DJS 2012-02: changed to rename from -stringForKey: due to a conflict with 10.7.3.
 */

- (NSString *)utilities_descriptionForKey:(id)key;
{
    return [self[key] description];
}

/**
 Returns the length of the object interpreted as a string.  See also -containsSomethingForKey:, below.
 
 @author DJS 2005-02.
 */

- (NSInteger)utilities_stringLengthForKey:(id)key;
{
    return [[self utilities_descriptionForKey:key] length];
}

/**
 Returns YES if the object interpreted as a string is non-empty, i.e. not nil and not @"".  See also -stringLengthForKey:, above.
 
 @author DJS 2005-02.
 */

- (BOOL)utilities_containsSomethingForKey:(id)key;
{
    return ([[self utilities_descriptionForKey:key] length] > 0);
}

/**
 Returns an entry's value given its key, or a NSNumber with the aDefault boolean if no value is associated with aKey.
 
 @author DJS 2004-06.
 */

- (id)utilities_objectForKey:(id)aKey orBool:(BOOL)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = @(aDefault);
    
    return value;
}

/**
 Returns an entry's value given its key, or a NSNumber with the aDefault integer if no value is associated with aKey.
 
 @author DJS 2004-06.
 */

- (id)utilities_objectForKey:(id)aKey orInteger:(BOOL)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = @(aDefault);
    
    return value;
}

/**
 Returns an entry's value given its key, or the default value if no value is associated with aKey.
 
 @author DJS 2004-01.
 */

- (id)utilities_objectForKey:(id)aKey defaultValue:(id)aDefault;
{
    id value = self[aKey];
    
    if (!value)
        value = aDefault;
    
    return value;
}

/**
 Given an object, returns the key for its first occurrence in the receiver, or nil if it is nil or not present.  [Once 10.6 is the minimum, might want to use -keysOfEntriesPassingTest: instead for more flexiblity.]
 
 @author DJS 2010-07.
 */

- (id)utilities_keyForObject:(id)anObject;
{
    if (!anObject)
        return nil;
    
    for (NSString *key in self)
        if ([self[key] isEqual:anObject])
            return key;
    
    return nil;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableDictionary (Extension)

/**
 Sets a NSNumber value in the mutable dictionary with the specified key.
 
 @author DJS 2005-02.
 */

- (void)utilities_setBool:(BOOL)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 Sets a NSNumber value in the mutable dictionary with the specified key.
 
 @author DJS 2005-02.
 */

- (void)utilities_setInteger:(NSInteger)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 Sets a NSNumber value in the mutable dictionary with the specified key.
 
 @author DJS 2005-02.
 */

- (void)utilities_setFloat:(float)value forKey:(id)key;
{
    self[key] = @(value);
}

/**
 Sets a NSNumber value in the mutable dictionary with the specified key.
 
 @author DJS 2011-07.
 */

- (void)utilities_setTimeInterval:(NSTimeInterval)value forKey:(id)key
{
    self[key] = @(value);
}

/**
 If there is no object already set for the key, sets the default value.  If there was already a value, does nothing.
 
 @author DJS 2010-06.
 */

- (void)utilities_setDefaultValue:(id)aDefault forKey:(id)aKey;
{
    if (!self[aKey])
        self[aKey] = aDefault;
}

/**
 Adds an entry to the receiver, consisting of aKey and its corresponding value object anObject.  If anObject is nil, sets the default value instead; does nothing if both objects are nil.
 
 @author DJS 2004-01.
 */

- (void)utilities_setObject:(id)anObject forKey:(id)aKey defaultValue:(id)aDefault;
{
    if (anObject)
        self[aKey] = anObject;
    else if (aDefault)
        self[aKey] = aDefault;
}

/**
 Adds an entry to the receiver, consisting of aKey and its corresponding value object anObject.  If anObject is nil and removeIfNil is YES, the key is instead removed from the receiver, if already present, otherwise nothing happens; useful to avoid an exception when an object may be nil.  Note: invoking this with YES for removeIfNil is equivalent to using -setValue:forKey:, so better to use that.
 
 @author DJS 2004-01.
 */

- (void)utilities_setObject:(id)anObject forKey:(id)aKey removeIfNil:(BOOL)removeIfNil;
{
    if (anObject)
        self[aKey] = anObject;
    else if (removeIfNil)
        [self removeObjectForKey:aKey];
}

/**
 If oldObject is present in the receiver, it is replaced with newObject, otherwise this has no effect.  Only replaces the first occurrence [could add an argument to replace all if desired in the future].
 
 @author DJS 2010-07.
 */

- (void)utilities_replaceObject:(id)oldObject withObject:(id)newObject;
{
    NSString *key = [self utilities_keyForObject:oldObject];
    
    if (key && newObject)
        self[key] = newObject;
}

@end


