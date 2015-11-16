//
//  AzureManager.h
//  SimFin
//
//  Created by ELEKT M on 11/5/15.
//  Copyright © 2015 ELEKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "MSCoreDataStore_DataStoreExtensions.h"

@interface AzureManager : NSObject

/**
* Associated MSClient for the table supplied. 
* Only 1 instance is ever created for each table.
*/
+ (MSClient *)clientForTableWithName:(NSString *)tableName;

/**
 * Direct access to CRUD operations on the aure table supplied
 * Only 1 instance is ever created for each table.
 */
+ (MSTable *)cloudTableForTableNamed:(NSString *)tableName;

/**
 * MSSyncTable for Azure Mobile Services Offline Sync for the table name supplied
 * Only 1 instance is ever created for each table.
 */
+ (MSSyncTable *)tableForTableNamed:(NSString *)tableName;

/**
 * MSQuery assigned to the MSSyncTable, or a new MSQuery instance
 * Only 1 instance is ever created for each table.
 */
+ (MSQuery *)queryForTableNamed:(NSString *)tableName;

/**
 * The Azure Mobile Services App url & key, found on the dashboard page
 */
+ (void)launchWithAppUrlString:(NSString*)appUrl appKey:(NSString*)appKey;

/**
 * Connection queue to use for Azure operations
 */
+ (void)connectionQueueForAzure:(NSOperationQueue*)queue;

/**
 * All locally stored items for the Azure table
 * Only local items stored with offline sync are returned
 */
+ (NSArray *)itemsFromTable:(NSString *)table;

@end
