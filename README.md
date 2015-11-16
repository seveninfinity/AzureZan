##AzureZan - Windows Azure Mobile Table Interaction Zanity.

##Azure Manager & Mogenerator templates
**Azure Manager** - Wrapper to simplify interacting with the Windows Azure Mobile Services IOS SDK.
**Mogenerator templates** - Modified to allow you interact with your Entities in a more Azure friendly way.

----------

##Why do i need this
The Azure Mobile Services IOS SDK's offline data feature, uses core data, but changes made directly to **NSManagedObject** will not be synced with the built in **Push & Pull** methods. The SDK is designed to record changes, and then transmit those changes. All changes to a NSManagedObject must go through the SDK. 

A simpler way to look at this..
**Get Records:** Standard core data
**Change Records:** Create, update, delete operations performed using the SDK 

**Mogenerator to the rescue**
Mogenerator creates statically typed classes based on your core data entities. With additions that cater to the SDK's design, and interact with Azure Manager to simplify basic C-R-U-D, Push, Pull, and sync operations. The result is a implementation process that looks like this.
> - Create matching azure table and core data entity with the same name
> - Generate classes using mogenerator
> - Start Coding
> 

##Usage -Setup

Launch Azure Manager singleton with the **App URL** and **Public Key** to your **mobile service**. This is available from the dashboard.
``` objc
#import "AzureZan.h"

[AzureManager launchWithAppUrlString:@"" appKey:@""];
```

##Usage -With MoGenerator Templates
Lets say we have a local Core Data entity called **Transactions**, with a table in Azure also called **Transactions**. **Using the modified mogenerator templates** we can create, update, delete, and sync our local database with the cloud database. 

#### <i class="icon-refresh"></i> Push, Pull, Or Sync
``` objc
[Transactions pushToCloud];
[Transactions pushToCloudDone:^(NSError *error){ }];

[Transactions pullFromCloud];
[Transactions pullFromCloudDone:^(NSError *error){ }];

[Transactions pushAndpullFromCloud];
[Transactions pushAndpullFromCloudDone:^(NSError *error){ }];

```

#### <i class="icon-pencil"></i> Create
``` objc
[Transactions createItem:@{ @"name" : @"john" } 
	      completion:^(NSDictionary *item, NSError *error){
	//..
}];
```

#### <i class="icon-file"></i> Read
``` objc
// Local or Remote
[Transactions readItemWithId:@"1234-1234-1234-1234" 
	          completion:^(NSDictionary *item, NSError *error){
	//.. item[@"name"]
}];

// Locally stored NSManagedObject subclass
Transactions *transaction = [Transactions managedObjectWithAzureItemId:@""];
transaction.name;

// or just need a simple array of dictionaries for all locally stored records
NSArray *items = [Transactions allLocalRecords];
```

#### <i class="icon-pencil"></i> Update
``` objc
// Class Method
[Transaction updateWithDictionary:@{ @"id" : @"", @"name" : @"john"} 
                       completion:^(NSError *error) {
        
}];

// Instance Method
[transaction updateWithDictionary:@{ @"name" : @"john" } 
completion:^(NSError *error) {
        
}];
```

#### <i class="icon-trash"></i>  Delete
``` objc
// Class Method
[Transactions deleteItem:@{@"id" : @"1234-1234-1234-1234"} 
              completion:^(NSError *error) {
    
}];
// Instance Method
[transaction deleteWithCompletion:^(NSError *error) {
    
}];
```

**Utilities**
``` objc
// Convert to NSDictionary
NSDictionary *item = [transaction dictionaryRepresentation];

// All statically types properties
NSArray *properties = [transaction properties];
```

**Access to underlying Windows Azure Mobile Services SDK**
``` objc
// Associated MSSyncTable instance
MSSyncTable *syncTable = [Transaction azureSyncTable];

// Associated MSTable instance
MSTable *table = [Transaction azureTable];

// Associated MSClient instance
MSClient *tablesClient = [Transaction azureClient];

// Associated MSSyncContext instance
MSSyncContext *syncContext = [Transaction azureSyncContext];
```

##Azure Manager
**Azure Manager** replaces the need to create a custom service class to handle common interactions with MSSyncTable, MSClient, MSTable, MSCoreDataStore by creating these on-demand, or returning an existing instance we eliminate the need for this additional code. By using the custom mogenerator templates you will rarely have to deal with this class directly.
``` objc
// MSSyncTable
[AzureManager tableForTableNamed:@"TableName"];

// MSTable
[AzureManager cloudTableForTableNamed:@"TableName"];

// MSClient
[AzureManager clientForTableWithName:@"TableName"];

// Example
MSSyncTable *syncTable = [AzureManager tableForTableNamed:@"TableName"];
[syncTable insert:@{} completion:nil];
[syncTable update:@{} completion:nil];
[syncTable delete:@{} completion:nil];
```

##Custom Templates & Mogenerator
This is just a quick guide, a more in-depth guide by John Blanco is available here http://raptureinvenice.com/getting-started-with-mogenerator/

> **Install MoGenerator Templates:**
> 
> - Install mogenerator http://rentzsch.github.com/mogenerator/
> - Copy custom mogenerator templates to a location of your choosing
> - Open XCode -> Select Project Name 
> - Press + under targets
> - Select Other -> Aggregate -> Name it "mogenerator"
> - Select  your newly created target
> - Add "new run script phase"
> - Modify the script below with your custom location
> - Build to the new Aggregate target
> - Copy the files generated into your project
> 

```
mogenerator -m ${PROJECT_NAME}/${PROJECT_NAME}.xcdatamodeld 
-H ${PROJECT_NAME}/Model 
--template-var arc=true 
--template-path /Path/To/Where/Ever/You/Put/The/Templates
```
