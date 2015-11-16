##AzureZan - Windows Azure Mobile Services -Faster 
**Azure Manager** - Wrapper to simplify interacting with the Windows Azure Mobile Services IOS SDK through interacting with the associated mogenerator generated NSManagedObject subclasses.
**Mogenerator templates** - Modified to enable and extend interaction with your core data entities in a more Azure friendly way for the offline data, and sync features of the SDK.
[AzureZan-mogenerator](https://github.com/seveninfinity/AzureZan-mogenerator)

----------

###Why do i need this
The Azure Mobile Services IOS SDK's offline data feature, uses core data, but changes made directly to **NSManagedObject** will not be synced with the built in **Push & Pull** methods. The SDK is designed to record changes, and then transmit those changes. All changes to a NSManagedObject must go through the SDK. 

> - **Get Records:**  Standard core data, fetch, sort, same as any core data project.
> - **Change or Create:** All changes, updates, deletions are made with a dictionary representation, and performed using the SDK. Changes made directly to the NSManagedObject are not synced.


**Mogenerator [custom templates](https://github.com/seveninfinity/AzureZan-mogenerator) to the rescue**
[Mogenerator](https://rentzsch.github.io/mogenerator/) creates statically typed classes based on your core data entities (...I know lame description). With additions that cater to the SDK's design, and interact with Azure Manager to simplify basic C-R-U-D, Push, Pull, and sync operations. The result is a implementation process that looks like this.
> - Create matching **azure table** and **core data entity** with the same name
> - Generate statically types NSManagedObject subClasses using mogenerator
> - Start Coding
> 

###Usage -Setup

Launch Azure Manager singleton with the **App URL** and **Public Key** to your **mobile service**. This is available from the dashboard.

AppDelegate.h
``` objc
#import "AzureZan.h"

[AzureManager launchWithAppUrlString:@"App_Url" 
                              appKey:@"App_Key"];
```

### Usage -With Custom MoGenerator [Templates](https://github.com/seveninfinity/AzureZan-mogenerator)
Lets say we have a local Core Data entity called **TodoItems**, with a table in Azure also called **TodoItems**. **Using the custom mogenerator templates** we can create, update, and delete items locally, and sync the changes back to the mobile service in the cloud. The code to create and manage instances of MSSyncTable & MSClient are handled by AzureManager, and auto-magically generated with the custom mogenerator templates.

#### Push, Pull, Or Sync
``` objc
[TodoItems pushToCloud];
[TodoItems pushToCloudCompletion:^(NSError *error){ }];

[TodoItems pullFromCloud];
[TodoItems pullFromCloudCompletion:^(NSError *error){ }];

[TodoItems sync];
[TodoItems syncCompletion:^(NSError *error){ }];

```

#### Create
``` objc
[TodoItems createItem:@{ @"name" : @"john" } 
	      completion:^(NSDictionary *item, NSError *error){
	// Azure GUID (Azure Id != core data Id)
	item[@"id"];
	
	TodoItems *todoItem = [TodoItems managedObjectWithAzureItemId:item[@"id"]];
}];
```

#### Read
``` objc
// Local or Remote
[TodoItems readItemWithId:@"1234-1234-1234-1234" 
	          completion:^(NSDictionary *item, NSError *error){
	//.. 
}];

// Locally stored NSManagedObject subclass
TodoItems *todoItem = [TodoItems managedObjectWithAzureItemId:@""];
todoItem.name; // Typed access

// or just need a simple array of dictionaries for all locally stored records
NSArray *items = [TodoItems allLocalRecords];
```

#### Update
``` objc
// Class Method
[Transaction updateWithDictionary:@{ @"id" : @"", @"name" : @"john"} 
                       completion:^(NSError *error) {
        
}];

// Instance Method
[todoItem updateWithDictionary:@{ @"name" : @"john" } 
completion:^(NSError *error) {
        
}];
```

####  Delete
``` objc
// Class Method
[TodoItems deleteItem:@{@"id" : @"1234-1234-1234-1234"} 
              completion:^(NSError *error) {
    
}];
// Instance Method
[todoItem deleteWithCompletion:^(NSError *error) {
    
}];
```

#### Utilities
``` objc
// Convert to NSDictionary
NSDictionary *item = [todoItem dictionaryRepresentation];

// All statically types properties
NSArray *properties = [todoItem properties];

// This can also be achieved from the NSManagedObject, 
// I just find the above method cleaner, and readible
[[[todoItem entity] attributesByName] allKeys];
```

#### Access to underlying Windows Azure Mobile Services SDK
In case you want quick finer grained access to the object instances created/configured/managed by Azure Manager.
``` objc
// Associated MSSyncTable instance
MSSyncTable *syncTable = [Transaction azureSyncTable];

// Associated MSTable instance
MSTable *table = [Transaction azureTable];

// Associated MSClient instance
MSClient *tablesClient = [Transaction azureClient];

// Associated MSSyncContext instance
MSSyncContext *syncContext = [Transaction azureSyncContext];
MSSyncContext *syncContext = tablesClient.syncContext;
MSSyncContext *syncContext = syncTable.client.syncContext;

```

### Azure Manager
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

### Custom Templates & Mogenerator
This is just a quick guide, a more in-depth guide by John Blanco is available here http://raptureinvenice.com/getting-started-with-mogenerator/

> **Install MoGenerator Templates:**
> 
> - Install mogenerator http://rentzsch.github.com/mogenerator/
> - Clone [AzureZan-mogenerator](https://github.com/seveninfinity/AzureZan-mogenerator) templates
> - From build targets -> Add new target (+) 
> - Select Other -> Aggregate -> Name it "mogenerator" or "Bob"
> - Add "new run script phase" to the new build target
> - Modify the script below with the mogenerator templates location
> - Build the Aggregate target
> - Add the files generated into your project
> 

```
mogenerator -m ${PROJECT_NAME}/${PROJECT_NAME}.xcdatamodeld 
-H ${PROJECT_NAME}/Model 
--template-var arc=true 
--template-path "/Path/To/Where Ever/You/Put/The/Templates"
```

Links
[Mogenerator](https://rentzsch.github.io/mogenerator/)
[Mogenerator Default Features](http://stackoverflow.com/questions/22566121/what-features-does-mogenerator-provide)
[Get Started With Mogenerator](http://raptureinvenice.com/getting-started-with-mogenerator/)

Author
[Brian Nelson](https://www.linkedin.com/in/nelson79) - Not to be confused with the | 29 other programmers of the same name | 3k linked-in profiles | 375k google results. 