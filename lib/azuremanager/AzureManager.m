//
//  AzureManager.m
//  SimFin
//
//  Created by ELEKT M on 11/5/15.
//  Copyright © 2015 ELEKT. All rights reserved.
//


#import "AzureManager.h"
#import "AppDelegate.h"

@interface AzureManager()
@property(nonatomic, strong) NSMutableDictionary *services;
@property(nonatomic, strong) NSMutableDictionary *clients;
@property(nonatomic, strong) NSMutableDictionary *querys;

@property(nonatomic, strong) NSString *appUrl;
@property(nonatomic, strong) NSString *appKey;

@property(nonatomic, strong) MSCoreDataStore *sharedDataStore;

@property (nonatomic, strong) NSOperationQueue *connectionDelegateQueue;
@end

@implementation AzureManager


+ (AzureManager *)shared {
    static AzureManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[AzureManager alloc] init];
        _shared.services = [NSMutableDictionary dictionaryWithCapacity:5];
        _shared.clients = [NSMutableDictionary dictionaryWithCapacity:5];
        _shared.querys = [NSMutableDictionary dictionaryWithCapacity:5];
    });
    
    return _shared;
}

+ (NSArray *)itemsFromTable:(NSString *)table {
    
    NSError *error = nil;
    MSCoreDataStore *storeRef = [ [[AzureManager clientForTableWithName:table] syncContext] dataSource];
    MSSyncTable *syncTable = [[self class] tableForTableNamed:table];
    MSQuery *query = [[MSQuery alloc] initWithSyncTable:syncTable];
    MSSyncContextReadResult *result =
    [storeRef readWithQuery:query orError:&error];
    
    if (error) {
        return nil;
    }
    
    return result.items;
}


#pragma mark - Settings
+ (void)launchWithAppUrlString:(NSString*)appUrl appKey:(NSString*)appKey{
    [[AzureManager shared] setAppUrl:appUrl];
    [[AzureManager shared] setAppKey:appKey];
}

+ (void)connectionQueueForAzure:(NSOperationQueue*)queue{
    [[AzureManager shared] setConnectionDelegateQueue:queue];
}

#pragma mark - MSTable
+ (MSTable *)cloudTableForTableNamed:(NSString *)tableName{
    
    return  [[AzureManager clientForTableWithName:tableName] tableWithName:tableName];
}

#pragma mark - MSQuery
+ (MSQuery *)queryForTableNamed:(NSString *)tableName{
    return [[AzureManager shared] existingOrNewQueryForTableWithName:tableName];
}
- (MSQuery *)existingOrNewQueryForTableWithName:(NSString *)tableName{

    
    if (!!self.querys[tableName]) {
        return _querys[tableName];
    }
    
    // Get existing query from sync table
    MSQuery *query = [[self existingOrNewTableForTableWithName:tableName] query];
    
    // Or create with synctable
    if (!query) {
        query = [[MSQuery alloc] initWithSyncTable:[self existingOrNewTableForTableWithName:tableName]];
    }
    
    // Set fetch and paramaters for sync setup
    query.parameters = nil;
    //query.fetchLimit = 1000;
    
    _querys[tableName] = query;
    
    return _querys[tableName];
}

#pragma mark - MSSyncTable
+ (MSSyncTable *)tableForTableNamed:(NSString *)tableName {
    MSSyncTable *syncTable =
    [[AzureManager shared] existingOrNewTableForTableWithName:tableName];
    
    return syncTable;
}
- (MSSyncTable *)existingOrNewTableForTableWithName:(NSString *)tableName {

    NSString *tableAsAzureName = tableName;
    
    // Return Existing Service
    if (!!self.services[tableAsAzureName]) {
        return _services[tableAsAzureName];
    }
    
    // Creates a new client for each sync table
    MSClient *clientForTable = [self existingOrNewClientForTableWithName:tableAsAzureName];
    
    clientForTable.syncContext = [[MSSyncContext alloc] initWithDelegate:nil
                                                              dataSource:self.sharedDataStore
                                                                callback:nil];
    [_services addEntriesFromDictionary:@{
                                          tableAsAzureName : [clientForTable syncTableWithName:tableAsAzureName]
                                          }];
    
    return self.services[tableAsAzureName];
}

#pragma mark - MSClient
+ (MSClient *)clientForTableWithName:(NSString *)tableName {
    return [[AzureManager tableForTableNamed:tableName] client];
}
- (MSClient *)existingOrNewClientForTableWithName:(NSString *)tableName {
    
    if (!!self.clients[tableName]) {
        
        MSClient *client = self.clients[tableName];
//        if (!client.currentUser) {
//            client.currentUser = [client userFromSavedUser];
//        }
        return client;
        
    } else {
        
                MSClient *client = [MSClient clientWithApplicationURLString:self.appUrl
                                                             applicationKey:self.appKey];
        
//        MSClient *client = [MSClient clientFromSavedSessionWithApplicationURLString:self.appUrl
//                                                                     applicationKey:self.appKey];

        client.connectionDelegateQueue = self.connectionDelegateQueue;
        [self.clients addEntriesFromDictionary:@{   tableName : client  }];
        
        return self.clients[tableName];
    }
}

#pragma mark - MSCoreDataStore
- (MSCoreDataStore *)sharedDataStore {
    if (_sharedDataStore) {
        return _sharedDataStore;
    }
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    _sharedDataStore = [[MSCoreDataStore alloc] initWithManagedObjectContext:context];
    
    return _sharedDataStore;
}

@end
