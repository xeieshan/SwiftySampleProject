//
//  NSObject+Utilities.m

#import "NSObject+Utilities.h"

@implementation NSObject (Utilities)

- (void)utilities_delayedAddOperation:(NSOperation *)operation {
    [[NSOperationQueue currentQueue] addOperation:operation];
}



- (void)utilities_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(utilities_delayedAddOperation:)
               withObject:[NSBlockOperation blockOperationWithBlock:block]
               afterDelay:delay];
}



- (void)utilities_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay cancelPreviousRequest:(BOOL)cancel {
    if (cancel) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    [self utilities_performBlock:block afterDelay:delay];
}

@end


@implementation NSObject (Extension)


// ----------------------------------------------------------------------------------------
#pragma mark - KEY VALUE CODING METHODS
// ----------------------------------------------------------------------------------------


/**
 Returns the value for the key path, or the default value if that key path is invalid (instead of throwing an exception).
 
 @param keyPath Path to the value.
 @param defaultValue Value to use if the path is invalid or the value is NSNull; may be nil.
 @return The value from the path, or the defaultValue.
 
 @author DJS 2013-12.
 @version DJS 2014-01: to return the default value if NSNull.
 */

- (id)utilities_valueForKeyPath:(NSString *)keyPath defaultValue:(id)defaultValue;
{
    id result = nil;
    
    @try
    {
        result = [self valueForKeyPath:keyPath];
        
        if (!result || [result isEqual:[NSNull null]])
            result = defaultValue;
    }
    
    @catch (NSException *exception)
    {
        result = defaultValue;
    }
    
    return result;
}

/**
 Tries to get a value from the dictionary via the key.  If a value is found, it is set in the receiver, using the same key, otherwise no change is made.  Useful for setting properties from a dictionary.
 
 @author DJS 2011-02.
 */

- (void)utilities_setValueForKey:(NSString *)key withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 Tries to get a value from the dictionary via the first key.  If there isn't one, tries the alternative key.  If a value is found, it is set in the receiver, using the first key, otherwise no change is made.  Useful for setting properties from a dictionary.
 
 @author DJS 2011-02.
 */

- (void)utilities_setValueForKey:(NSString *)key orDictKey:(NSString *)altKey withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (!value && altKey)
        value = dict[altKey];
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 Tries to get a value from the dictionary via the first key.  If there isn't one, tries the alternative keys until a value is found.  If a value is found, it is set in the receiver, using the first key, otherwise no change is made.  Useful for setting properties from a dictionary.
 
 @author DJS 2011-02.
 */

- (void)utilities_setValueForKey:(NSString *)key orDictKeys:(NSArray *)altKeys withDictionary:(NSDictionary *)dict;
{
    id value = dict[key];
    
    if (!value && altKeys)
    {
        for (NSString *altKey in altKeys)
            if (!value)
                value = dict[altKey];
    }
    
    if (value)
        [self setValue:value forKey:key];
}

/**
 If there is a value for the specified key in the receiver, it is set in the dictionary, otherwise this does nothing.
 
 @author DJS 2011-02.
 */

- (void)utilities_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key;
{
    [self utilities_setValueInDictionary:dict forKey:key removeIfNil:NO];
}

/**
 If there is a value for the specified key in the receiver, it is set in the dictionary.  If there isn't a value, the key is optionally removed from the dictionary.  Passing YES is equivalent to calling [dict setValue:[self valueForKey:key] forKey:key].
 
 @author DJS 2011-02.
 */

- (void)utilities_setValueInDictionary:(NSMutableDictionary *)dict forKey:(NSString *)key removeIfNil:(BOOL)removeIfNil;
{
    id value = [self valueForKey:key];
    
    if (value)
        dict[key] = value;
    else if (removeIfNil)
        [dict removeObjectForKey:key];
}


// ----------------------------------------------------------------------------------------
#pragma mark - IDENTITY METHODS
// ----------------------------------------------------------------------------------------


/**
 Returns YES if the receiver is an instance of a subclass of aClass, but not an instance of aClass itself.
 
 @author DJS 2004-01.
 */

- (BOOL)utilities_isReallySubclassOfClass:(Class)aClass
{
    return [self isKindOfClass:aClass] && ![self isMemberOfClass:aClass];
}


/**
 Like -isEqual, but returns YES if the receiver and the other object are equal when both interpreted as case-insensitive strings.  So, for example, @"THIS" and @"This" are equivalent, and @"123" and [NSNumber numberWithInteger:123] are equivalent.  If the other object is nil, returns NO; i.e. a non-nil receiver is not equivalent to a nil value (but, of course, sending this to a nil object will result in 0, which would be incorrect if the other object were also nil).
 
 @author DJS 2005-03.
 */

- (BOOL)utilities_isEquivalent:(id)anObject
{
    if (anObject)
        return ([[self description] caseInsensitiveCompare:[anObject description]] == NSOrderedSame);
    else
        return NO;
}

/**
 An alias of -isEquivalent:, for when the "To" makes more sense.  For efficiency, the logic is duplicated.
 
 @author DJS 2005-05.
 */

- (BOOL)utilities_isEquivalentTo:(id)anObject
{
    if (anObject)
        return ([[self description] caseInsensitiveCompare:[anObject description]] == NSOrderedSame);
    else
        return NO;
}


// ----------------------------------------------------------------------------------------
#pragma mark - PERFORM SELECTOR METHODS
// ----------------------------------------------------------------------------------------


/**
 Similar to -performSelector:, but calls a method that returns a boolean value.  Returns NO if the receiever doesn't respond to that selector.
 
 @author DJS 2006-06.
 */

- (BOOL)utilities_performBoolSelector:(SEL)selector;
{
    return [self utilities_performIntegerSelector:selector withObject:[NSNull null] withObject:[NSNull null]];
}

/**
 Similar to -performSelector:withObject:, but calls a method that returns a boolean value.  Returns NO if the receiever doesn't respond to that selector.
 
 @author DJS 2006-06.
 */

- (BOOL)utilities_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object;
{
    return [self utilities_performIntegerSelector:selector withObject:object withObject:[NSNull null]];
}

/**
 Similar to -performSelector:withObject:withObject:, but calls a method that returns a boolean value.  Returns NO if the receiever doesn't respond to that selector.
 
 @author DJS 2006-06.
 */

- (BOOL)utilities_performBoolSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2;
{
    return [self utilities_performIntegerSelector:selector withObject:object1 withObject:object2];
}

/**
 Similar to -performSelector:, but calls a method that returns an integer value.  Returns zero if the receiever doesn't respond to that selector.
 
 @author DJS 2004-04.
 */

- (NSInteger)utilities_performIntegerSelector:(SEL)selector
{
    return [self utilities_performIntegerSelector:selector withObject:[NSNull null] withObject:[NSNull null]];
}

/**
 Similar to -performSelector:withObject:, but calls a method that returns an integer value.  Returns zero if the receiever doesn't respond to that selector.
 
 @author DJS 2004-04.
 */

- (NSInteger)utilities_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object
{
    return [self utilities_performIntegerSelector:selector withObject:object withObject:[NSNull null]];
}

/**
 Similar to -performSelector:withObject:withObject:, but calls a method that returns an integer value.  Does nothing (and returns zero) if selector is nil or the receiver doesn't respond to that selector.
 
 @author DJS 2004-04.
 */

- (NSInteger)utilities_performIntegerSelector:(SEL)selector withObject:(__unsafe_unretained id)object1 withObject:(__unsafe_unretained id)object2
{
    if (!selector || ![self respondsToSelector:selector])
        return 0;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    NSInteger result = 0;
    
    [invocation setSelector:selector];
    
    if (![object1 isKindOfClass:[NSNull class]])
        [invocation setArgument:&object1 atIndex:2];
    
    if (![object2 isKindOfClass:[NSNull class]])
        [invocation setArgument:&object2 atIndex:3];
    
    [invocation invokeWithTarget:self];
    [invocation getReturnValue:&result];
    
    return result;
}

/**
 Similar to -performSelector:withObject:, but allows any number of arguments.  The arguments are taken from the array, in order.  The selector should expect the same number of arguments.  It's okay for arguments to be nil, if the selector doesn't take any.  Does nothing if selector is nil, or the number of arguments of the selector and array are different.
 
 @author DJS 2007-03.
 */

- (void)utilities_performSelector:(SEL)selector withArguments:(NSArray *)arguments;
{
    if (!selector)
        return;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    // Exclude the hidden self and _cmd arguments:
    if (([signature numberOfArguments] - 2) != [arguments count])
    {
        NSLog(@"performSelector:%@ withObjects:%@ has different number of arguments", NSStringFromSelector(selector), arguments);         // log
        
        return;
    }
    
    [invocation setSelector:selector];
    
    for (NSUInteger i = 0; i < [arguments count]; i++)
    {
        __unsafe_unretained id object = arguments[i];
        
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    [invocation invokeWithTarget:self];
}

/**
 Invokes the selector, passing each object in the array as a parameter.  Not the same as -[NSArray makeObjectsPerformSelector:], as that makes the objects in the array perform the selector, instead of making the receiver object perform the selector.  The selector must take a single argument.
 
 @author DJS 2004-10.
 @version DJS 2014-12: changed to add a workaround for a compiler warning.
 */

- (void)utilities_performSelector:(SEL)selector withEachObjectInArray:(NSArray *)array
{
    id object;
    
    for (object in array)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }
}

/**
 Invokes the selector, passing each object in the dictionary as a parameter.  The order invoked is not defined.  See -performSelector:withEachObjectInArray: for more information.
 
 @author DJS 2004-10.
 */

- (void)utilities_performSelector:(SEL)selector withEachObjectInDictionary:(NSDictionary *)dict
{
    [self utilities_performSelector:selector withEachObjectInArray:[dict allValues]];
}

/**
 Invokes the selector, passing each object in the set as a parameter.  The order invoked is not defined.  See -performSelector:withEachObjectInArray: for more information.
 
 @author DJS 2004-10.
 */

- (void)utilities_performSelector:(SEL)selector withEachObjectInSet:(NSSet *)set
{
    [self utilities_performSelector:selector withEachObjectInArray:[set allObjects]];
}

@end


