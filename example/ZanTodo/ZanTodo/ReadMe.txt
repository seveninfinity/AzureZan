Before running this sample

1. Create a new Windows Azure Mobile Service
https://azure.microsoft.com/en-us/documentation/articles/mobile-services-ios-get-started/#create-a-new-ios-app

2. Get the app url & key from the dashboard in the portal for you mobile service
In the appDelegate file replace with your url/key
[AzureManager launchWithAppUrlString:@"APPURL" appKey:@"APPKEY"];

3. Download Azure Mobile Service IOS SDK
https://github.com/Azure/azure-mobile-services/blob/master/CHANGELOG.ios.md#sdk-downloads

4. Add Azure Mobile Service IOS SDK to project

5. Create a table in the Azure portal called "TodoItem"


MoGenerator
1. Custom Templates can be cloned here
https://github.com/seveninfinity/AzureZan-mogenerator

2. Modify the template path of the Aggregate Target, Run script phase
mogenerator -m ${PROJECT_NAME}/${PROJECT_NAME}.xcdatamodeld -H ${PROJECT_NAME}/Model -M ${PROJECT_NAME}/Model --template-var arc=true --template-path "/Directory/You/Cloned/These/In/AzureZan-mogenerator"