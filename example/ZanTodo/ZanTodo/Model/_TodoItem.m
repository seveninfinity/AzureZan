// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TodoItem.m instead.

#import "_TodoItem.h"

const struct TodoItemAttributes TodoItemAttributes = {
	.complete = @"complete",
	.id = @"id",
	.ms_createdAt = @"ms_createdAt",
	.ms_deleted = @"ms_deleted",
	.ms_updatedAt = @"ms_updatedAt",
	.ms_version = @"ms_version",
	.text = @"text",
};

@implementation TodoItemID
@end

@implementation _TodoItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TodoItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TodoItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TodoItem" inManagedObjectContext:moc_];
}

+ (_TodoItem*)managedObjectWithAzureItemId:(NSString*)itemId
{
    MSCoreDataStore *dataSource = [[[_TodoItem azureClient] syncContext] dataSource];

    return [dataSource getRecordForTable:@"TodoItem"
                                  itemId:itemId
                            asDictionary:NO
                                 orError:nil];
}

- (TodoItemID*)objectID {
	return (TodoItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"completeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"complete"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ms_deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ms_deleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

- (NSDictionary *)dictionaryRepresentation
{
	NSMutableDictionary *dict = [NSMutableDictionary new];
	[dict setObjectIfNotNil:self.complete forKey:@"complete"];
	[dict setObjectIfNotNil:self.id forKey:@"id"];
	[dict setObjectIfNotNil:self.ms_createdAt forKey:@"ms_createdAt"];
	[dict setObjectIfNotNil:self.ms_deleted forKey:@"ms_deleted"];
	[dict setObjectIfNotNil:self.ms_updatedAt forKey:@"ms_updatedAt"];
	[dict setObjectIfNotNil:self.ms_version forKey:@"ms_version"];
	[dict setObjectIfNotNil:self.text forKey:@"text"];

	return dict;
}

+ (NSArray*)properties
{
    return @[
	@"complete",
	@"id",
	@"ms_createdAt",
	@"ms_deleted",
	@"ms_updatedAt",
	@"ms_version",
	@"text",
	];
}

+ (NSArray*)allLocalRecords
{
	return [AzureManager itemsFromTable:@"TodoItem"];
}

// Azure Table Abstractions
+ (MSSyncTable*)azureSyncTable
{
    return [AzureManager tableForTableNamed:@"TodoItem"];
}

+ (MSTable*)azureTable
{
    return [AzureManager cloudTableForTableNamed:@"TodoItem"];
}

+ (MSClient*)azureClient
{
    return [AzureManager clientForTableWithName:@"TodoItem"];
}
+ (MSSyncContext*)azureSyncContext{
    return [[_TodoItem azureClient] syncContext];
}

// Azure Sync
+ (void)pushToCloud
{
    [_TodoItem pushToCloudCompletion:nil];
}
+ (void)pushToCloudCompletion:(MSSyncBlock)completion
{
    [[[_TodoItem azureClient] syncContext] pushWithCompletion:completion];
}

+ (void)pullFromCloud
{
    [_TodoItem pullFromCloudCompletion:nil];
}
+ (void)pullFromCloudCompletion:(MSSyncBlock)completion
{
    [[_TodoItem azureSyncTable] pullWithQuery:[AzureManager queryForTableNamed:@"TodoItem"]
                                          queryId:@"TodoItem"
                                       completion:completion];
}

+ (void)sync
{
    [_TodoItem syncCompletion:nil];
}
+ (void)syncCompletion:(MSSyncBlock)completion
{
    [_TodoItem pushToCloudCompletion:^(NSError *error) {
        [_TodoItem pullFromCloudCompletion:completion];
    }];
}

// Azure CRUD Abstractions
+(void)createItem:(NSDictionary *)item completion:(MSSyncItemBlock)completion
{
    [[_TodoItem azureSyncTable] insert:item completion:completion];
}

+(void)readItemWithId:(NSString *)itemId completion:(MSItemBlock)completion
{
    [[_TodoItem azureSyncTable] readWithId:itemId completion:completion];
}
+(void)updateItem:(NSDictionary *)item completion:(MSSyncBlock)completion
{
	[[_TodoItem azureSyncTable] update:item completion:completion];
}
-(void)updateWithDictionary:(NSDictionary *)item completion:(MSSyncBlock)completion
{
    NSMutableDictionary *dict = [[self dictionaryRepresentation] mutableCopy];
    [item enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [dict setObjectIfNotNil:obj forKey:key];
    }];
    [[_TodoItem azureSyncTable] update:dict completion:completion];
}
-(void)deleteWithCompletion:(MSSyncBlock)completion
{
    [[_TodoItem azureSyncTable] delete:[self dictionaryRepresentation] completion:completion];
}
+(void)deleteItem:(NSDictionary *)item completion:(MSSyncBlock)completion
{
    [[_TodoItem azureSyncTable] delete:item completion:completion];
}

@dynamic complete;

- (BOOL)completeValue {
	NSNumber *result = [self complete];
	return [result boolValue];
}

- (void)setCompleteValue:(BOOL)value_ {
	[self setComplete:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompleteValue {
	NSNumber *result = [self primitiveComplete];
	return [result boolValue];
}

- (void)setPrimitiveCompleteValue:(BOOL)value_ {
	[self setPrimitiveComplete:[NSNumber numberWithBool:value_]];
}

@dynamic id;

@dynamic ms_createdAt;

@dynamic ms_deleted;

- (BOOL)ms_deletedValue {
	NSNumber *result = [self ms_deleted];
	return [result boolValue];
}

- (void)setMs_deletedValue:(BOOL)value_ {
	[self setMs_deleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveMs_deletedValue {
	NSNumber *result = [self primitiveMs_deleted];
	return [result boolValue];
}

- (void)setPrimitiveMs_deletedValue:(BOOL)value_ {
	[self setPrimitiveMs_deleted:[NSNumber numberWithBool:value_]];
}

@dynamic ms_updatedAt;

@dynamic ms_version;

@dynamic text;

@end

