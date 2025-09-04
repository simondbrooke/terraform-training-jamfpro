# Section 2 - Overview

This section is going to cover a lot about configuration profiles and other management resources like Policies, Smart Groups and others.

Configuration profiles in the Jamf Provider are slightly different to all other resources. The process will be to have an XML/PLIST file of the configuration and then use that to configure the terraform resource.

The main way of doing this would be to create the configuration profile in the Jamf UI in the first place, preferably in your sandbox tenant, use the Deployment Theory Jamf Pro GoLang SDK or the Jamf Pro API to download the unsigned plist and then use the plist to create your Terraform resource which will be used to promote the change through your production Route to Live.

In this section, you will be covering the following topics:

- [Lesson 1 - Smart Groups](/support_materials/Section%202%20-%20Management/Lesson%201%20-%20Scoping%20Groups/Lesson%201%20-%20Scoping%20Groups.md)
- [Lesson 2 - Extension Attributes](/support_materials/Section%202%20-%20Management/Lesson%202%20-%20Extension%20Attributes/Lesson%202%20-%20Extension%20Attributes.md)
- [Lesson 3 - Policies](/support_materials/Section%202%20-%20Management/Lesson%203%20-%20Policies/Lesson%203%20-%20Policies.md)
- [Lesson 4 - Configuration Resource Creation](/support_materials/Section%202%20-%20Management/Lesson%204%20-%20Configuration%20Resource%20Creation/Lesson%204%20-%20Configuration%20Resource%20Creation.md)
- [Lesson 5 - Computer Configurations](/support_materials/Section%202%20-%20Management/Lesson%205%20-%20Computer%20Configurations/Lesson%205%20-%20Computer%20Configurations.md)
- [Lesson 6 - Mobile Device Configurations](/support_materials/Section%202%20-%20Management/Lesson%206%20-%20Mobile%20Device%20Configurations/Lesson%206%20-%20Mobile%20Device%20Configurations.md)
- [Section 2 Review](/support_materials/Section%202%20-%20Management/Section%202%20-%20Review/Section%202%20-%20Review.md)

In this section, to create the Configuration Profiles, you are going to need to use the [Jamf Pro GO SDK](https://github.com/deploymenttheory/go-api-sdk-jamfpro) in the deploymenttheory GitHub repo. Please download this and follow the setup guide in the repo prior to the Configuration Profile lesson. You will also need to install the Go programming language on the machine which you can follow the steps on the [go.dev webpage](https://go.dev/doc/install).

Use **Option 2** in the setup guide when it is discussing your variables for authentication and create a config file.
