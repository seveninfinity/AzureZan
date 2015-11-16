// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TodoItem.h instead.

#import <CoreData/CoreData.h>

#import "AzureZan.h"

extern const struct TodoItemAttributes {
	__unsafe_unretained NSString *complete;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *ms_createdAt;
	__unsafe_unretained NSString *ms_deleted;
	__unsafe_unretained NSString *ms_updatedAt;
	__unsafe_unretained NSString *ms_version;
	__unsafe_unretained NSString *text;
} TodoItemAttributes;

@interface TodoItemID : NSManagedObjectID {}
@end

@interface _TodoItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;

#pragma mark -
#pragma mark - Azure Additions (C-R-U-D)
#pragma mark - Create Item
+(void)createItem:(NSDictionary *)item completion:(MSSyncItemBlock)completion;

#pragma mark - Read Item
+(void)readItemWithId:(NSString *)itemId completion:(MSItemBlock)completion;
+ (_TodoItem*)managedObjectWithAzureItemId:(NSString*)itemId;

#pragma mark - Update Item
+(void)updateItem:(NSDictionary *)item completion:(MSSyncBlock)completion;
-(void)updateWithDictionary:(NSDictionary *)item completion:(MSSyncBlock)completion;

#pragma mark - Delete Item
-(void)deleteWithCompletion:(MSSyncBlock)completion;
+(void)deleteItem:(NSDictionary *)item completion:(MSSyncBlock)completion;

#pragma mark - Azure Push, Pull, And Sync
+ (void)pushToCloud;
+ (void)pushToCloudCompletion:(MSSyncBlock)completion;
+ (void)pullFromCloud;
+ (void)pullFromCloudCompletion:(MSSyncBlock)completion;
+ (void)sync;
+ (void)syncCompletion:(MSSyncBlock)completion;

#pragma mark - Info
+ (NSString*)entityName;
+ (NSArray*)properties;

#pragma mark - Utilities
- (NSDictionary *)dictionaryRepresentation;
+ (NSArray*)allLocalRecords;

#pragma mark - Windows Azure Mobile Services Underlying SDK
+ (MSSyncTable*)azureSyncTable;
+ (MSTable*)azureTable;
+ (MSClient*)azureClient;
+ (MSSyncContext*)azureSyncContext;

@property (nonatomic, readonly, strong) TodoItemID* objectID;

@property (nonatomic, strong) NSNumber* complete;

@property (atomic) BOOL completeValue;
- (BOOL)completeValue;
- (void)setCompleteValue:(BOOL)value_;

@property (nonatomic, strong) NSString* id;

@property (nonatomic, strong) NSDate* ms_createdAt;

@property (nonatomic, strong) NSNumber* ms_deleted;

@property (atomic) BOOL ms_deletedValue;
- (BOOL)ms_deletedValue;
- (void)setMs_deletedValue:(BOOL)value_;

@property (nonatomic, strong) NSDate* ms_updatedAt;

@property (nonatomic, strong) NSString* ms_version;

@property (nonatomic, strong) NSString* text;

@end

@interface _TodoItem (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveComplete;
- (void)setPrimitiveComplete:(NSNumber*)value;

- (BOOL)primitiveCompleteValue;
- (void)setPrimitiveCompleteValue:(BOOL)value_;

- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;

- (NSDate*)primitiveMs_createdAt;
- (void)setPrimitiveMs_createdAt:(NSDate*)value;

- (NSNumber*)primitiveMs_deleted;
- (void)setPrimitiveMs_deleted:(NSNumber*)value;

- (BOOL)primitiveMs_deletedValue;
- (void)setPrimitiveMs_deletedValue:(BOOL)value_;

- (NSDate*)primitiveMs_updatedAt;
- (void)setPrimitiveMs_updatedAt:(NSDate*)value;

- (NSString*)primitiveMs_version;
- (void)setPrimitiveMs_version:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

@end
