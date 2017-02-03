//
//  SampleStorageHelper.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import "SampleStorageHelper.h"

@implementation SampleStorageHelper
@synthesize traversed;
#pragma mark - Core Data Stack

+ (NSManagedObjectContext *) managedObjectContext
{
    static NSManagedObjectContext* managedObjectContext_ = nil;
    
    if (managedObjectContext_ != nil)
    {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [[self class] persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        managedObjectContext_ = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        managedObjectContext_.persistentStoreCoordinator = coordinator;
    }
    
    return managedObjectContext_;
}


+ (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    static NSPersistentStoreCoordinator* persistentStoreCoordinator_ = nil;
    
    if (persistentStoreCoordinator_ != nil)
    {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[[self class] applicationDocumentsDirectory] stringByAppendingPathComponent:DbName]];
    
    //    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@(YES), NSInferMappingModelAutomaticallyOption:@(YES)};
    
    NSLog(@"Db Path URL: %@",storeURL);
    
    NSError *error = nil;
    
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[[self class] managedObjectModel]];
    
    //Model versioned names
    NSArray* modelNames = @[@"ModelName"];
    
    if (![SampleStorageHelper iterativeMigrateURL:storeURL
                                       ofType:NSSQLiteStoreType
                                      toModel:[[self class] managedObjectModel]
                            orderedModelNames:modelNames
                                        error:&error])
    {
        NSLog(@"Error migrating to latest model: %@\n %@", error, [error userInfo]);
    }
    
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return persistentStoreCoordinator_;
}


+ (NSManagedObjectModel *) managedObjectModel
{
    static NSManagedObjectModel* managedObjectModel_ = nil;
    
    if (managedObjectModel_ != nil)
    {
        return managedObjectModel_;
    }
    
    managedObjectModel_ = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel_;
}

+ (NSString *) applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



#pragma mark - IO Operations

+ (NSManagedObject *)create
{
    NSString *entityName = [NSString stringWithFormat:@"%@",[self class]];
    
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[[self class] managedObjectContext]];
    
    return obj;
}

+ (void) save
{
    [[[self class] managedObjectContext] performBlock:^{
        
        NSError *error;
        if (![[[self class] managedObjectContext] save:&error])
        {
            NSLog(@"Error in Saving: %@", error.localizedDescription);
        }
    }];
}

+ (void) deleteObject:(NSManagedObject *)object
{
    [[self managedObjectContext] deleteObject:object];
    
    [[self class] save];
}

+ (void) deleteAllObjects
{
    for (NSManagedObject *obj in [[self class] fetchAll])
    {
        [[[self class] managedObjectContext] deleteObject:obj];
    }
    
    [[self class] save];
}

+ (NSArray *) fetchAll
{
    return [[self class] fetchWithPredicate:nil sortDescriptor:nil fetchLimit:0];
}

+ (NSArray *) fetchWithPredicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit
{
    NSString *entityName = [NSString stringWithFormat:@"%@",[self class]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[[self class] managedObjectContext]];
    [fetchRequest setFetchBatchSize:30];
    [fetchRequest setEntity:entity];
    
    if (filter != nil)
    {
        [fetchRequest setPredicate:filter];
    }
    if (sortDescriptors != nil)
    {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    if (limit > 0)
    {
        [fetchRequest setFetchLimit:limit];
    }
    
    NSError *error = nil;
    
    NSArray *result = [[[self class] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (!result)
    {
        NSLog(@"Error in Getting Core-Data Record: %@", error.localizedDescription);
        return nil;
    }
    
    return result;
}

+ (NSArray *) fetchWithEntity:(NSString *)entityName predicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[[self class] managedObjectContext]];
    [fetchRequest setFetchBatchSize:30];
    [fetchRequest setEntity:entity];
    
    if (filter != nil)
    {
        [fetchRequest setPredicate:filter];
    }
    if (sortDescriptors != nil)
    {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    if (limit > 0)
    {
        [fetchRequest setFetchLimit:limit];
    }
    
    NSError *error = nil;
    
    NSArray *result = [[[self class] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (!result)
    {
        NSLog(@"Error in Getting Core-Data Record: %@", error.localizedDescription);
        return nil;
    }
    
    return result;
}

+ (NSInteger) count
{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:[NSString stringWithFormat:@"%@",[self class]]]
    ;
    __block NSUInteger rCount = 0;
    
    [[[self class] managedObjectContext] performBlockAndWait:^()
     {
         NSError *error;
         rCount = [[[self class] managedObjectContext] countForFetchRequest:fr error:&error];
         
         if (rCount == NSNotFound) {
             NSLog(@"Error in Retrieving items: %@", error.localizedDescription);
         } }];
    
    NSLog(@"Retrieved %d items", (int)rCount);
    return rCount;
}

+ (int) maxIdOfAttributs:(NSString *)attribute
{
    NSString *entityName = [NSString stringWithFormat:@"%@",[self class]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:attribute ascending:NO]];
    
    NSError *error = nil;
    
    NSManagedObject *objNSManagedObject = [[[self class] managedObjectContext] executeFetchRequest:fetchRequest error:&error].lastObject;
    
    if (objNSManagedObject)
    {
        return [[objNSManagedObject valueForKey:attribute] intValue];
    }
    
    return 0;
}

+ (id)isManagedObjectAlreadyExist:(NSString *)entityName withPredicate:(NSPredicate *)filter
{
    return [SampleStorageHelper isManagedObjectAlreadyExist:entityName withPredicate:filter inContext:[SampleStorageHelper managedObjectContext]];
}

+ (id)isManagedObjectAlreadyExist:(NSString *)entityName withPredicate:(NSPredicate *)filter inContext:(NSManagedObjectContext *)objContext
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:objContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    [fetchRequest setPredicate:filter];
    
    NSError *error = nil;
    NSArray *result = [objContext executeFetchRequest:fetchRequest error:&error];
    
    return [result lastObject];
}

+ (NSArray *)fetchWithPredicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit resultType:(NSFetchRequestResultType)resultType fetchProperties:(NSArray *)properties returnDistinctResult:(BOOL)distinct{
    
    
    NSString *entityName = [NSString stringWithFormat:@"%@",[self class]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:[[self class] managedObjectContext]];
    [fetchRequest setFetchBatchSize:30];
    [fetchRequest setEntity:entity];
    [fetchRequest setResultType:resultType];
    [fetchRequest setPropertiesToFetch:properties];
    [fetchRequest setReturnsDistinctResults:distinct];
    
    if (filter != nil)
    {
        [fetchRequest setPredicate:filter];
    }
    if (sortDescriptors != nil)
    {
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    if (limit > 0)
    {
        [fetchRequest setFetchLimit:limit];
    }
    
    NSError *error = nil;
    
    NSArray *result = [[[self class] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (!result)
    {
        NSLog(@"Error in Getting Core-Data Record: %@", error.localizedDescription);
        return nil;
    }
    
    return result;    
}


/**
 *  Manual Migration
 */

+ (BOOL)iterativeMigrateURL:(NSURL*)sourceStoreURL
                     ofType:(NSString*)sourceStoreType
                    toModel:(NSManagedObjectModel*)finalModel
          orderedModelNames:(NSArray*)modelNames
                      error:(NSError**)error
{
    // If the persistent store does not exist at the given URL,
    // assume that it hasn't yet been created and return success immediately.
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:[sourceStoreURL path]])
    {
        return YES;
    }
    
    // Get the persistent store's metadata.  The metadata is used to
    // get information about the store's managed object model.
    NSDictionary* sourceMetadata =
    [self metadataForPersistentStoreOfType:sourceStoreType
                                       URL:sourceStoreURL
                                     error:error];
    if (nil == sourceMetadata)
    {
        return NO;
    }
    
    // Check whether the final model is already compatible with the store.
    // If it is, no migration is necessary.
    if ([finalModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata])
    {
        return YES;
    }
    
    // Find the current model used by the store.
    NSManagedObjectModel * sourceModel = [self modelForStoreMetadata:sourceMetadata error:error];
    if (nil == sourceModel)
    {
        return NO;
    }
    
    // Get NSManagedObjectModels for each of the model names given.
    NSArray* models = [self modelsNamed:modelNames error:error];
    if (nil == models)
    {
        return NO;
    }
    
    // Build an inclusive list of models between the source and final models.
    NSMutableArray* relevantModels = [NSMutableArray array];
    BOOL firstFound = NO;
    BOOL lastFound = NO;
    BOOL reverse = NO;
    for (NSManagedObjectModel* model in models)
    {
        if ([model isEqual:sourceModel] || [model isEqual:finalModel])
        {
            if (firstFound)
            {
                lastFound = YES;
                // In case a reverse migration is being performed (descending through the
                // ordered array of models), check whether the source model is found
                // after the final model.
                reverse = [model isEqual:sourceModel];
            }
            else
            {
                firstFound = YES;
            }
        }
        
        if (firstFound)
        {
            [relevantModels addObject:model];
        }
        
        if (lastFound)
        {
            break;
        }
    }
    
    // Ensure that the source model is at the start of the list.
    if (reverse)
    {
        relevantModels =
        [[[relevantModels reverseObjectEnumerator] allObjects] mutableCopy];
    }
    
    // Migrate through the list
    for (int i = 0; i < ([relevantModels count] - 1); i++)
    {
        NSManagedObjectModel* modelA = [relevantModels objectAtIndex:i];
        NSManagedObjectModel* modelB = [relevantModels objectAtIndex:(i + 1)];
        
        // Check whether a custom mapping model exists.
        NSMappingModel* mappingModel = [NSMappingModel mappingModelFromBundles:nil
                                                                forSourceModel:modelA
                                                              destinationModel:modelB];
        
        // If there is no custom mapping model, try to infer one.
        if (nil == mappingModel)
        {
            mappingModel = [NSMappingModel inferredMappingModelForSourceModel:modelA
                                                             destinationModel:modelB
                                                                        error:error];
            if (nil == mappingModel)
            {
                return NO;
            }
        }
        
        if (![self migrateURL:sourceStoreURL
                       ofType:sourceStoreType
                    fromModel:modelA
                      toModel:modelB
                 mappingModel:mappingModel
                        error:error])
        {
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)migrateURL:(NSURL*)sourceStoreURL
            ofType:(NSString*)sourceStoreType
         fromModel:(NSManagedObjectModel*)sourceModel
           toModel:(NSManagedObjectModel*)targetModel
      mappingModel:(NSMappingModel*)mappingModel
             error:(NSError**)error
{
    // Build a temporary path to write the migrated store.
    NSURL* tempDestinationStoreURL =
    [NSURL fileURLWithPath:[[sourceStoreURL path] stringByAppendingPathExtension:@"tmp"]];
    
    // Migrate from the source model to the target model using the mapping,
    // and store the resulting data at the temporary path.
    NSMigrationManager* migrator = [[NSMigrationManager alloc]
                                    initWithSourceModel:sourceModel
                                    destinationModel:targetModel];
    
    if (![migrator migrateStoreFromURL:sourceStoreURL
                                  type:sourceStoreType
                               options:nil
                      withMappingModel:mappingModel
                      toDestinationURL:tempDestinationStoreURL
                       destinationType:sourceStoreType
                    destinationOptions:nil
                                 error:error])
    {
        return NO;
    }
    
    // Move the original source store to a backup location.
    NSString* backupPath = [[sourceStoreURL path] stringByAppendingPathExtension:@"bak"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager moveItemAtPath:[sourceStoreURL path]
                              toPath:backupPath
                               error:error])
    {
        // If the move fails, delete the migrated destination store.
        [fileManager moveItemAtPath:[tempDestinationStoreURL path]
                             toPath:[sourceStoreURL path]
                              error:NULL];
        return NO;
    }
    
    // Move the destination store to the original source location.
    if ([fileManager moveItemAtPath:[tempDestinationStoreURL path]
                             toPath:[sourceStoreURL path]
                              error:error])
    {
        // If the move succeeds, delete the backup of the original store.
        [fileManager removeItemAtPath:backupPath error:NULL];
    }
    else
    {
        // If the move fails, restore the original store to its original location.
        [fileManager moveItemAtPath:backupPath
                             toPath:[sourceStoreURL path]
                              error:NULL];
        return NO;
    }
    
    return YES;
}

+ (NSString*)errorDomain
{
    return @"com.<#Project Name#>.tmp.SampleProject";
}

#pragma mark - Private methods

// Returns an NSError with the give code and localized description,
// and this class' error domain.
+ (NSError*)errorWithCode:(NSInteger)code description:(NSString*)description
{
    NSDictionary* userInfo = @{
                               NSLocalizedDescriptionKey: description
                               };
    
    return [NSError errorWithDomain:[SampleStorageHelper errorDomain]
                               code:code
                           userInfo:userInfo];
    
    return NO;
}

// Gets the metadata for the given persistent store.
+ (NSDictionary*)metadataForPersistentStoreOfType:(NSString*)storeType
                                              URL:(NSURL*)url
                                            error:(NSError **)error
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDictionary* sourceMetadata =
    [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:storeType URL:url error:error];
    #pragma clang diagnostic pop
    
    if (nil == sourceMetadata && NULL != error)
    {
        NSString* errorDesc = [NSString stringWithFormat:
                               @"Failed to find source metadata for store: %@",
                               url];
        *error = [self errorWithCode:102 description:errorDesc];
    }
    
    return sourceMetadata;
}

// Finds the source model for the store described by the given metadata.
+ (NSManagedObjectModel*)modelForStoreMetadata:(NSDictionary*)metadata
                                         error:(NSError**)error
{
    NSManagedObjectModel* sourceModel = [NSManagedObjectModel
                                         mergedModelFromBundles:nil
                                         forStoreMetadata:metadata];
    if (nil == sourceModel && NULL != error)
    {
        NSString* errorDesc = [NSString stringWithFormat:
                               @"Failed to find source model for metadata: %@",
                               metadata];
        *error = [self errorWithCode:100 description:errorDesc];
    }
    
    return sourceModel;
}

// Returns an array of NSManagedObjectModels loaded from mom files with the given names.
// Returns nil if any model files could not be found.
+ (NSArray*)modelsNamed:(NSArray*)modelNames
                  error:(NSError**)error
{
    NSMutableArray* models = [NSMutableArray array];
    for (NSString* modelName in modelNames)
    {
        NSURL* modelUrl = [self urlForModelName:modelName inDirectory:nil];
        NSManagedObjectModel* model =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
        
        if (nil == model)
        {
            if (NULL != error)
            {
                NSString* errorDesc =
                [NSString stringWithFormat:@"No model found for %@ at URL %@", modelName, modelUrl];
                *error = [self errorWithCode:110 description:errorDesc];
            }
            return nil;
        }
        
        [models addObject:model];
    }
    return models;
}

// Returns an array of paths to .mom model files in the given directory.
// Recurses into .momd directories to look for .mom files.
// @param directory The name of the bundle directory to search.  If nil,
//    searches default paths.
+ (NSArray*)modelPathsInDirectory:(NSString*)directory
{
    NSMutableArray* modelPaths = [NSMutableArray array];
    
    // Get top level mom file paths.
    [modelPaths addObjectsFromArray:
     [[NSBundle mainBundle] pathsForResourcesOfType:@"mom"
                                        inDirectory:directory]];
    
    // Get mom file paths from momd directories.
    NSArray* momdPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd"
                                                            inDirectory:directory];
    for (NSString* momdPath in momdPaths)
    {
        NSString* resourceSubpath = [momdPath lastPathComponent];
        
        [modelPaths addObjectsFromArray:
         [[NSBundle mainBundle]
          pathsForResourcesOfType:@"mom"
          inDirectory:resourceSubpath]];
    }
    
    return modelPaths;
}

// Returns the URL for a model file with the given name in the given directory.
// @param directory The name of the bundle directory to search.  If nil,
//    searches default paths.
+ (NSURL*)urlForModelName:(NSString*)modelName
              inDirectory:(NSString*)directory
{
    NSBundle* bundle = [NSBundle mainBundle];
    NSURL* url = [bundle URLForResource:modelName
                          withExtension:@"mom"
                           subdirectory:directory];
    if (nil == url)
    {
        // Get mom file paths from momd directories.
        NSArray* momdPaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"momd"
                                                                inDirectory:directory];
        for (NSString* momdPath in momdPaths)
        {
            url = [bundle URLForResource:modelName
                           withExtension:@"mom"
                            subdirectory:[momdPath lastPathComponent]];
        }
    }
    
    return url;
}

#pragma mark- NSDictionary to CoreData object and Vise Versa

- (NSDictionary*) toDictionary
{
    self.traversed = YES;
    
    NSArray* attributes = [[[self entity] attributesByName] allKeys];
    NSArray* relationships = [[[self entity] relationshipsByName] allKeys];
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:
                                 [attributes count] + [relationships count] + 1];
    
    [dict setObject:[[self class] description] forKey:@"class"];
    
    for (NSString* attr in attributes) {
        NSObject* value = [self valueForKey:attr];
        
        if (value != nil) {
            [dict setObject:value forKey:attr];
        }
    }
    
    for (NSString* relationship in relationships) {
        NSObject* value = [self valueForKey:relationship];
        
        if ([value isKindOfClass:[NSSet class]]) {
            // To-many relationship
            
            // The core data set holds a collection of managed objects
            NSSet* relatedObjects = (NSSet*) value;
            
            // Our set holds a collection of dictionaries
            NSMutableSet* dictSet = [NSMutableSet setWithCapacity:[relatedObjects count]];
            
            for (SampleStorageHelper* relatedObject in relatedObjects) {
                if (!relatedObject.traversed) {
                    [dictSet addObject:[relatedObject toDictionary]];
                }
            }
            
            [dict setObject:dictSet forKey:relationship];
        }
        else if ([value isKindOfClass:[SampleStorageHelper class]]) {
            // To-one relationship
            
            SampleStorageHelper* relatedObject = (SampleStorageHelper*) value;
            
            if (!relatedObject.traversed) {
                // Call toDictionary on the referenced object and put the result back into our dictionary.
                [dict setObject:[relatedObject toDictionary] forKey:relationship];
            }
        }
    }
    
    return dict;
}

- (void) populateFromDictionary:(NSDictionary*)dict
{
    NSManagedObjectContext* context = [self managedObjectContext];
    
    for (NSString* key in dict) {
        if ([key isEqualToString:@"class"]) {
            continue;
        }
        
        NSObject* value = [dict objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            // This is a to-one relationship
            SampleStorageHelper* relatedObject =
            [SampleStorageHelper createManagedObjectFromDictionary:(NSDictionary*)value
                                                           inContext:context];
            
            [self setValue:relatedObject forKey:key];
        }
        else if ([value isKindOfClass:[NSSet class]]) {
            // This is a to-many relationship
            NSSet* relatedObjectDictionaries = (NSSet*) value;
            
            // Get a proxy set that represents the relationship, and add related objects to it.
            // (Note: this is provided by Core Data)
            NSMutableSet* relatedObjects = [self mutableSetValueForKey:key];
            
            for (NSDictionary* relatedObjectDict in relatedObjectDictionaries) {
                SampleStorageHelper* relatedObject =
                [SampleStorageHelper createManagedObjectFromDictionary:relatedObjectDict
                                                               inContext:context];
                [relatedObjects addObject:relatedObject];
            }
        }
        else if (value != nil) {
            // This is an attribute
            [self setValue:value forKey:key];
        }
    }
}

+ (SampleStorageHelper*) createManagedObjectFromDictionary:(NSDictionary*)dict
                                                   inContext:(NSManagedObjectContext*)context
{
    NSString* class = [dict objectForKey:@"class"];
    SampleStorageHelper* newObject =
    (SampleStorageHelper*)[NSEntityDescription insertNewObjectForEntityForName:class
                                                          inManagedObjectContext:context];
    
    [newObject populateFromDictionary:dict];
    
    return newObject;
}


@end
