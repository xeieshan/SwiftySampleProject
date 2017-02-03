//
//  SampleStorageHelper.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SampleStorageHelper : NSManagedObject
{
    BOOL traversed;
}

@property (nonatomic, assign) BOOL traversed;


#define DbName @"ANYNAME.sqlite"

#pragma mark - Core Data Stack

+ (NSManagedObjectContext *) managedObjectContext;
+ (NSPersistentStoreCoordinator *) persistentStoreCoordinator;
+ (NSManagedObjectModel *) managedObjectModel;
+ (NSString *) applicationDocumentsDirectory;



#pragma mark - IO Operations

+ (NSManagedObject *)create;
+ (void) save;

+ (void) deleteObject:(NSManagedObject *)object;
+ (void) deleteAllObjects;

+ (NSArray *) fetchAll;
+ (NSArray *) fetchWithPredicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit;
+ (NSArray *) fetchWithEntity:(NSString *)entity predicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit;

+ (NSInteger) count;

+ (int) maxIdOfAttributs:(NSString *)attribute;

+ (id)isManagedObjectAlreadyExist:(NSString *)entityName withPredicate:(NSPredicate *)filter;
+ (id)isManagedObjectAlreadyExist:(NSString *)entityName withPredicate:(NSPredicate *)filter inContext:(NSManagedObjectContext *)objContext;
+ (NSArray *)fetchWithPredicate:(NSPredicate *)filter sortDescriptor:(NSArray *)sortDescriptors fetchLimit:(int)limit resultType:(NSFetchRequestResultType)resultType fetchProperties:(NSArray *)properties returnDistinctResult:(BOOL)distinct;


/**
 *  Manual Migration
 */

+ (BOOL)iterativeMigrateURL:(NSURL*)sourceStoreURL
                     ofType:(NSString*)sourceStoreType
                    toModel:(NSManagedObjectModel*)finalModel
          orderedModelNames:(NSArray*)modelNames
                      error:(NSError**)error;

+ (BOOL)migrateURL:(NSURL*)sourceStoreURL
            ofType:(NSString*)sourceStoreType
         fromModel:(NSManagedObjectModel*)sourceModel
           toModel:(NSManagedObjectModel*)targetModel
      mappingModel:(NSMappingModel*)mappingModel
             error:(NSError**)error;

+ (NSString*)errorDomain;

#pragma mark - Private methods

// Returns an NSError with the give code and localized description,
// and this class' error domain.
+ (NSError*)errorWithCode:(NSInteger)code description:(NSString*)description;

// Gets the metadata for the given persistent store.
+ (NSDictionary*)metadataForPersistentStoreOfType:(NSString*)storeType
                                              URL:(NSURL*)url
                                            error:(NSError **)error;

// Finds the source model for the store described by the given metadata.
+ (NSManagedObjectModel*)modelForStoreMetadata:(NSDictionary*)metadata
                                         error:(NSError**)error;

// Returns an array of NSManagedObjectModels loaded from mom files with the given names.
// Returns nil if any model files could not be found.
+ (NSArray*)modelsNamed:(NSArray*)modelNames
                  error:(NSError**)error;

// Returns an array of paths to .mom model files in the given directory.
// Recurses into .momd directories to look for .mom files.
// @param directory The name of the bundle directory to search.  If nil,
//    searches default paths.
+ (NSArray*)modelPathsInDirectory:(NSString*)directory;

// Returns the URL for a model file with the given name in the given directory.
// @param directory The name of the bundle directory to search.  If nil,
//    searches default paths.
+ (NSURL*)urlForModelName:(NSString*)modelName
              inDirectory:(NSString*)directory;


#pragma mark- NSDictionary to CoreData object and Vise Versa

- (NSDictionary*) toDictionary;
- (void) populateFromDictionary:(NSDictionary*)dict;
+ (SampleStorageHelper*) createManagedObjectFromDictionary:(NSDictionary*)dict
                                                 inContext:(NSManagedObjectContext*)context;



@end
