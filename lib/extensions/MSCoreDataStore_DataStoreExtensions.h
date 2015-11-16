//
//  MSCoreDataStore_DataStoreExtensions.h
//  BarPal
//
//  Created by ELEKT M on 7/8/15.
//  Copyright (c) 2015 Seven Infinity. All rights reserved.
//

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface MSCoreDataStore ()

//@property (nonatomic, readonly) NSManagedObjectContext *context;

- (NSManagedObjectContext *)context;

- (id)getRecordForTable:(NSString *)table itemId:(NSString *)itemId asDictionary:(BOOL)asDictionary orError:(NSError **)error;

- (MSSyncContextReadResult *)readWithQuery:(MSQuery *)query orError:(NSError *__autoreleasing *)error;

@end
