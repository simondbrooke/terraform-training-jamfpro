# Lesson 4 - Configuration Resource Creation

Creating Configuration Profiles is a little more difficult than creating policies, because it relies on having an unsigned PLIST of the configuration to upload to the Jamf Pro tenant. This can be done in a number of ways, but the easiest way is to use the [Jamf Pro GO SDK](https://github.com/deploymenttheory/go-api-sdk-jamfpro) mentioned in the [Section Overview]().

This lesson will cover how to set up the Jamf Pro GO SDK and how to create and download the Configuration Profile that will be used in the next lesson to create the Configuration Profile resource.

## Configuring the Jamf Pro GO SDK

Following the steps on the deploymenttheory GitHub repo, you should now have the repo downloaded, and a config file configured with your API Client and Secret. You can now move on to setting up the script that you will use to download the configuration profile.

Follow these steps:

1. In the `go-api-sdk-jamfpro-main` directory, browse to `/go-api-sdk-jamfpro-main/recipes/macos_configuration_profiles/ExportMacOSConfigurationProfileToFile/ExportMacOSConfigurationProfileToFile.go` file.
2. Find the following block of code:

```
// Global configuration variables
var (
	configFilePath = "/Users/gordondeacon/github/config.json"
	exportDir      = "/Users/Shared/"
	profileID      = "6063" // Set your desired profile ID here
)
```

3. Configure these variables to meet the needs of the task.
   - `configFilePath` should be configured to point to your config file you created when setting up this project that holds your Client ID and Secret
   - `exportDir` should be configured to point to a location that you wish to save your exported configuration profile to
   - `profileID` needs to point to the Configuration Profile ID that you wish to download from your Jamf Pro tenant

## Creating the Configuration Profile in Jamf Pro

So that we can download the Configuration Profile, it has to be created in the Jamf Pro tenant. This may seem counter productive, why is it getting created in the Jamf Pro UI and then re-created in Terraform?

This is for a few reasons. The main one being so that everything is created in code and is managed by the Terraform provider. Another reason is that in a Route to Live environment, you would create the Configuration Profile in the UI, then download it, delete the profile, and push it through your Route to Live using only the one definition in code, rather than needing to duplicate effort across all of your tenants.

So in this section, you will create a configuration profile that can be downloaded in the next part of this lesson.

Follow these steps:

1. Sign in to your Jamf Pro tenant
2. Create a Configuration Profile, this can be of anything
3. Save the profile
4. Take note of the ID of the profile which is found in the URL of the Jamf Pro Tenant

## Downloading the Configuration Profile

Now that everything is set up, you can now use the GO SDK to download the Configuration Profile.

To do this, follow these steps:

1. Ensure that everything is configured as mentioned in the steps above, namely the `configFile`, `exportDir` and `profileID`
2. The `profileID` should be configured to point to the new configuration profile that you have just created
3. Browse to the `/go-api-sdk-jamfpro-main/recipes/macos_configuration_profiles/ExportMacOSConfigurationProfileToFile/` directory in your terminal
4. Now that everything is set up, run `go run ExportMacOSConfigurationProfileToFile.go`
5. This should export your PLIST file to wherever you have set your `exportDir` variable to

Now that you have this file, you can continue to your next lesson
