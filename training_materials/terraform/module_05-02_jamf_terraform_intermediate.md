# Section 2 - Overview

This section is going to cover a lot about configuration profiles and other management resources like Policies, Smart Groups and others.

Configuration profiles in the Jamf Provider are slightly different to all other resources. The process will be to have an XML/PLIST file of the configuration and then use that to configure the terraform resource.

The main way of doing this would be to create the configuration profile in the Jamf UI in the first place, preferably in your sandbox tenant, use the Deployment Theory Jamf Pro GoLang SDK or the Jamf Pro API to download the unsigned plist and then use the plist to create your Terraform resource which will be used to promote the change through your production Route to Live.

In this section, you will be covering the following topics:

- [Lesson 1 - Smart Groups](#lesson-1---scoping-groups)
- [Lesson 2 - Extension Attributes](#lesson-2---extension-attributes)
- [Lesson 3 - Policies](#lesson-3---policies)
- [Lesson 4 - Configuration Resource Creation](#lesson-4---configuration-resource-creation)
- [Lesson 5 - Computer Configurations](#lesson-5---computer-configurations)
- [Lesson 6 - Mobile Device Configurations](#lesson-6---mobile-device-configurations)

In this section, to create the Configuration Profiles, you are going to need to use the [Jamf Pro GO SDK](https://github.com/deploymenttheory/go-api-sdk-jamfpro) in the deploymenttheory GitHub repo. Please download this and follow the setup guide in the repo prior to the Configuration Profile lesson. You will also need to install the Go programming language on the machine which you can follow the steps on the [go.dev webpage](https://go.dev/doc/install).

Use **Option 2** in the setup guide when it is discussing your variables for authentication and create a config file.

---

## Lesson 1 - Scoping Groups

This lesson will describe how to create Smart Group resources. Using similar techniques as in the previous section, you can create smart groups in your terraform project and then link to them in policies either by their ID in Jamf Pro or by using the resource ID in Terraform. Using the Terraform resource ID can make the codebase dynamic and will mean that whenever you update the Smart Group, it will automatically sync with whatever the smart group is scoped to.

In this lesson, we will cover the following topics:

- [Static Computer & Mobile Device Groups](#static-computer--mobile-groups)
- [Smart Computer & Mobile Device Groups](#smart-computer--mobile-groups)

For more information on any of the resources we are going to create today, you can see the full breakdown from the schema on the [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources) webpage.

### Static Computer & Mobile Groups

Static Computer Groups in Terraform require you to know all Computer IDs in Jamf Pro so that you can scope the specific devices to the Group. Creating Static Computer Groups can be done by using the following resource:

```
resource "jamfpro_static_computer_group" "jamfpro_static_computer_group_001" {
  name = "Example Static Computer Group"


  ## Optional Block
  site_id = 1

  ## Optional: Specify computers for static groups
  assigned_computer_ids = [1, 2, 3]
}
```

The only required attribute in this resource is the `name`. Although, if you actually want to scope devices to the group, you will need to have the `assigned_computer_ids` attribute configured as well.

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/static_computer_group) webpage.

Mobile Device Groups are similar to the Computer Groups, except the resource block would be:

```
resource "jamfpro_static_mobile_device_group" "jamfpro_static_mobile_device_group_001" {
  name = "Example Mobile Device Group"


  ## Optional Block
  site_id = 1

  ## Optional: Specify computers for static groups
  assigned_mobile_device_ids = [1, 2, 3]
}
```

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/static_mobile_device_group) webpage.

### Smart Computer & Mobile Groups

Smart Groups in Terraform work exactly the same as the way that Smart Groups work in the Jamf Pro UI. You will be required to know the criteria and operators for the criteria. To create a Smart Computer Group in Terraform, you can use the following resource:

```
resource "jamfpro_smart_computer_group" "smart_example" {
  name = "Example Smart Computer Group"

  ## Optional: Specify site details
  site_id = 5

  ## Optional: Define criteria for Smart groups
  criteria {
    name          = "Criterion Name #1"
    priority      = 0     ## 0 is the highest priority, 1 is the next highest, etc.
    and_or        = "and" ## or "or", defaults to "and" if not provided
    search_type   = "is"  ## or any other supported search type
    value         = "Criterion Value"
    opening_paren = false ## true or false, defaults to false if not provided
    closing_paren = false ## true or false, defaults to false if not provided
  }

  criteria {
    name          = "Criterion Name #n+1 etc"
    priority      = 1
    and_or        = "and" ## or "or", defaults to "and" if not provided
    search_type   = "is"  ## or any other supported search type
    value         = "Criterion Value"
    opening_paren = false ## true or false, defaults to false if not provided
    closing_paren = false ## true or false, defaults to false if not provided
  }

}
```

The only required attribute for a Smart Computer group is the `name` attribute. All other attributes are optional, but required if you want to define a group that computers are scoped to, similar to if you were using the UI.

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/smart_computer_group) webpage.

Smart Mobile Device Groups work the exact same as Smart Computer Groups, just using a different resource. This resource is resource for Smart Mobile Device Groups:

```
resource "jamfpro_smart_mobile_device_group" "smart_example" {
  name = "Example Smart Mobile Device Group"

  ## Optional: Specify site details
  site_id = 5

  ## Optional: Define criteria for Smart groups
  criteria {
    name          = "Criterion Name #1"
    priority      = 0     ## 0 is the highest priority, 1 is the next highest, etc.
    and_or        = "and" ## or "or", defaults to "and" if not provided
    search_type   = "is"  ## or any other supported search type
    value         = "Criterion Value"
    opening_paren = false ## true or false, defaults to false if not provided
    closing_paren = false ## true or false, defaults to false if not provided
  }

  criteria {
    name          = "Criterion Name #n+1 etc"
    priority      = 1
    and_or        = "and" ## or "or", defaults to "and" if not provided
    search_type   = "is"  ## or any other supported search type
    value         = "Criterion Value"
    opening_paren = false ## true or false, defaults to false if not provided
    closing_paren = false ## true or false, defaults to false if not provided
  }

}
```

You can see more about Static Mobile Device Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/smart_mobile_device_group) webpage.

#### Scoping Groups - Exercise 1 - Creating a Static Computer Group

In this exercise you will create a Static Computer Group using the resource mentioned above. This exercise requires that you have device records in your Jamf Pro instance so that you can use the Device ID's.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_static_computer_groups.tf`
2. Add in the resource mentioned in the Static Computer Groups section above and configure the Static Computer Group attributes by giving it a name and adding in some valid computer IDs from you Jamf Pro instance
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

#### Scoping Groups - Exercise 2 - Creating a Static Mobile Device Group

This exercise will be similar to the previous, but instead of creating a Static Computer Group, you will create a Static Mobile Device Group.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_static_mobile_device_groups.tf`
2. Follow the same steps as in Exercise 1, but using the Mobile Device Static Group resource.
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

#### Scoping Groups - Exercise 3 - Creating a Smart Computer Group

In this exercise you will create a Smart Computer Group using the resource mentioned above. In this exercise, you can create a Smart Group with whatever criteria that you want.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_smart_computer_groups.tf`
2. Add in the resource mentioned in the Smart Computer Groups section above and configure the Static Computer Group attributes by giving it a name and adding in a search criteria
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

#### Scoping Groups - Exercise 4 - Creating a Smart Mobile Device Group

This exercise will be similar to the previous, but instead of creating a Smart Computer Group, you will create a Smart Mobile Device Group.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_smart_mobile_device_groups.tf`
2. Follow the same steps in Exercise 3, but using the Mobile Device Smart Group resource.
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

---

## Lesson 2 - Extension Attributes

There are multiple ways to create Extension Attributes in Jamf, and in the same way, there are multiple ways to configure the Extension Attribute resource in Terraform. The following topics will be covered in this lesson:

- [Computer Extension Attributes](#computer-extension-attributes)
  - [Pop-up Menu Example](#pop-up-menu-example)
  - [Text Field Example](#text-field-example)
  - [Script Example](#script-example)
- [Mobile Device Extension Attribute](#mobile-device-extension-attributes)

For more information on any of the resources we are going to create today, you can see the full breakdown from the schema on the [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources) webpage.

### Computer Extension Attributes

Extension Attributes have multiple functions, and they all have different ways to be configured in Terraform. There are also 2 different types of Extension Attributes, one for Computers and one for Mobile Devices. The only difference with Mobile Devices is that you can't deploy a script extension attribute.

#### Pop-up Menu Example

Configuring an extension attribute with a pop-up menu can be configured using the following resource:

```
## Pop-up Menu Example
resource "jamfpro_computer_extension_attribute" "jamfpro_computer_extension_attribute_popup_menu_1" {
  name                   = "tf-ghatest-cexa-popup-menu-example"
  enabled                = true
  description            = "An attribute collected from a pop-up menu."
  input_type             = "POPUP"
  popup_menu_choices     = ["Option 1", "Option 2", "Option 3"]
  inventory_display_type = "USER_AND_LOCATION"
  data_type              = "STRING"
}
```

#### Text Field Example

To configure an extension attribute with a text field you can use the following resource:

```
## Text Field Example
resource "jamfpro_computer_extension_attribute" "computer_extension_attribute_text_field_1" {
  name                   = "tf-example-cexa-text-field-example"
  enabled                = true
  description            = "An attribute collected from a text field."
  input_type             = "TEXT"
  inventory_display_type = "HARDWARE"
  data_type              = "STRING"
}
```

#### Script Example

Configuring the script extension attribute has a little more involved, which needs to include a script which will be deployed to the devices. It can be configured using the following resource:

```
## Script Example
resource "jamfpro_computer_extension_attribute" "computer_extension_attribute_script_1" {
  name                   = "tf-example-cexa-hello-world"
  enabled                = true
  description            = "An attribute collected via a script."
  input_type             = "SCRIPT"
  script_contents        = "#!/bin/bash\necho 'Hello, World!!!!! :)'"
  inventory_display_type = "GENERAL"
  data_type              = "STRING"
}
```

This example shows an inline script contents. But this isn't the only way you can configure this example. You can use the same method as in the scripts lesson and point the script contents to a file and read the contents in that way.

There are 3 required fields in an extension attribute, the `name`, `enabled` and `input_type` attributes. Everything else is optional depending on the input type.

You can see more about Computer Extension Attributes on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/computer_extension_attribute) webpage.

### Mobile Device Extension Attributes

Mobile Device Extension Attributes are configured exactly the same as Computer Extension Attributes, just with a different resource. As mentioned previously, the main difference is that there is no Script input type on the Mobile Device Extension Attributes.

The following resource examples are how you would configure the Mobile Device Extension Attributes:

```
## Pop-up menu Example
resource "jamfpro_mobile_device_extension_attribute" "popup_menu_example" {
  name                   = "Device Location"
  description            = "The primary location where this device is used"
  data_type              = "STRING"
  inventory_display_type = "USER_AND_LOCATION"
  input_type             = "POPUP"
  popup_menu_choices = [
    "Head Office",
    "Branch Office",
    "Home Office",
    "Client Site"
  ]
}
```

```
## Text Field Example
resource "jamfpro_mobile_device_extension_attribute" "text_field_example" {
  name                   = "User Department"
  description            = "The department to which the device user belongs"
  data_type              = "STRING"
  inventory_display_type = "GENERAL"
  input_type             = "TEXT"
}
```

You can see more about Mobile Device Extension Attributes on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/mobile_device_extension_attribute) webpage.

#### Extension Attributes - Exercises

##### Exercise 1: Basic Attribute

Create a simple extension attribute called **Device Owner**:

- Type: `string`
- Input type: `text`
- Visible in inventory `GENERAL`
- Add a description: `"Person responsible for the mobile device"`

**Tasks:**

1. Write the Terraform configuration.
2. Run `terraform plan` and check the changes.
3. Apply the configuration.

---

##### Exercise 2: Drop-Down Options

Define a **Region** attribute that lets users select a region:

- Input type: `pop-up menu`
- Options: `EMEA`, `APAC`, `Americas`
- Visible in the `GENERAL` inventory

**Tasks:**

1. Configure the resource in Terraform.
2. Apply it, then log in to Jamf Pro and confirm the drop-down appears.

---

##### Exercise 3: Updating an Attribute

Start with an attribute called **Warranty Expiry**:

- Type: `DATE`
- Visible in the `GENERAL` inventory

**Tasks:**

1. Create the attribute and apply it.
2. Update the same attribute to make it visible in `USER_AND_LOCATION` inventory.
3. Add a description: `"Date the warranty expires"`.

---

##### Exercise 4: Multiple Attributes

Create two attributes at once:

1. **Project Code**
   - Type: `string`
   - Input type: `text`
   - Visible in `USER_AND_LOCATION` inventory
2. **Support Tier**
   - Input type: `pop-up menu`
   - Options: `Gold`, `Silver`, `Bronze`
   - Visible in `GENERAL` inventory

**Tasks:**

- Write both resources in one Terraform configuration.
- Apply and verify both in Jamf Pro.

---

##### Exercise 5: Drift Detection

1. Create an attribute called **Asset Tag**:
   - Type: `string`
   - Visible in `GENERAL` inventory
2. After applying, manually change the attribute in the Jamf Pro console (e.g., change the name or disable inventory visibility).
3. Run `terraform plan` to see how Terraform detects drift.
4. Use `terraform apply` to bring the resource back to the desired state.

---

## Lesson 3 - Policies

This tutorial introduces the Terraform **`jamfpro_policy`** resource (part of the `deploymenttheory/jamfpro` provider) and guides you through several hands-on lessons, so you can learn by doing.

---

### What Is `jamfpro_policy`?

The `jamfpro_policy` resource allows you to define and manage Jamf Pro Policies using Terraform, supporting Jamf Pro’s Classic and modern APIs via the community provider **deploymenttheory/jamfpro**.

This Terraform provider lets you codify device management resources—like policies, smart groups, scripts, configuration profiles—as infrastructure-as-code for Jamf Pro environments.

---

### The Policy Resource

To configure the Policy resource in Terraform, you can use the following example:

```hcl
resource "jamfpro_policy" "jamfpro_policy_001" {
  name                          = "tf-localtest-policy-template-001"
  enabled                       = false
  trigger_checkin               = false
  trigger_enrollment_complete   = false
  trigger_login                 = false
  trigger_network_state_changed = false
  trigger_startup               = false
  trigger_other                 = "EVENT" // "USER_INITIATED" for self service trigger , "EVENT" for an event trigger
  frequency                     = "Once per computer"
  retry_event                   = "none"
  retry_attempts                = -1
  notify_on_each_failed_retry   = false
  target_drive                  = "/"
  offline                       = false
  category_id                   = -1
  site_id                       = -1

  date_time_limitations {
    activation_date       = "2026-12-25 01:00:00"
    activation_date_epoch = 1798160400000
    activation_date_utc   = "2026-12-25T01:00:00.000+0000"
    expiration_date       = "2028-04-01 16:02:00"
    expiration_date_epoch = 1838217720000
    expiration_date_utc   = "2028-04-01T16:02:00.000+0000"
    no_execute_on         = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    no_execute_start      = "9:09 AM"
    no_execute_end        = "10:10 PM"
  }


  network_limitations {
    minimum_network_connection = "No Minimum"
    any_ip_address             = false
  }

  scope {
    all_computers = false
    all_jss_users = false

    computer_ids       = [16, 20, 21]
    computer_group_ids = sort([78, 1])
    building_ids       = ([1348, 1349])
    department_ids     = ([37287, 37288])
    jss_user_ids       = sort([2, 1])
    jss_user_group_ids = [4, 505]

    limitations {
      network_segment_ids                  = [4, 5]
      ibeacon_ids                          = [3, 4]
      directory_service_or_local_usernames = ["Jane Smith", "John Doe"]
      //directory_service_usergroup_ids = [3, 4]
    }

    exclusions {
      computer_ids                         = [16, 20, 21]
      computer_group_ids                   = sort([118, 1])
      building_ids                         = ([1348, 1349])
      department_ids                       = ([37287, 37288])
      network_segment_ids                  = [4, 5]
      jss_user_ids                         = sort([2, 1])
      jss_user_group_ids                   = [4, 505]
      directory_service_or_local_usernames = ["Jane Smith", "John Doe"]
      directory_service_usergroup_ids      = [3, 4]
      ibeacon_ids                          = [3, 4]
    }
  }

  self_service {
    use_for_self_service            = true
    self_service_display_name       = ""
    install_button_text             = "Install"
    reinstall_button_text           = "Reinstall"
    self_service_description        = ""
    force_users_to_view_description = false
    feature_on_main_page            = false
  }

  payloads {
    scripts {
      id          = 123
      priority    = "After"
      parameter4  = "param_value_4"
      parameter5  = "param_value_5"
      parameter6  = "param_value_6"
      parameter7  = "param_value_7"
      parameter8  = "param_value_8"
      parameter9  = "param_value_9"
      parameter10 = "param_value_10"
      parameter11 = "param_value_11"
    }

    disk_encryption {
      action                                     = "apply"
      disk_encryption_configuration_id           = 1
      auth_restart                               = false
      remediate_key_type                         = "Individual"
      remediate_disk_encryption_configuration_id = 2
    }
  }
}
```

This resource has a number of required attributes, including `enabled`, `name`, `payloads` and `scope`. There are a number of attributes for creating a policy within the `payloads` attribute, which is the same as if you were creating a policy in the Jamf Pro UI.

You can see more about Policies on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/policy) webpage.

---

#### Exercises

##### Exercise 1 - Creating a basic policy

Create a basic policy that runs a script on all devices. This lesson will be similar to the one created in the health check lesson in Section 1.

Using the resource above follow these steps:

1. If not already done so, create the script and policy that was mentioned [Section 1 - Lesson 1](/support_materials/Section%201%20-%20Configuration/Lesson%201%20-%20Infrastructure/Lesson%201%20-%20Infrastructure.md)
2. Use `terraform plan` and `terraform apply` to create the script and policy in your Jamf Pro instance
3. Once created, verify that the policy and script is created in your Jamf Pro instance

##### Exercise 2 - Modifying a policies scope

Now that you have created a basic policy in Jamf Pro. We are going to modify the policies scope to restrict it to a smart group that you created in a previous lesson in this section.

Using the same resource, follow these steps:

1. Modify the `scope` attribute to point the scope to the smart group created in the previous lesson. You can do this multiple ways, you can either point to the ID of the Smart Group by grabbing it from the UI, or as mentioned before, you can point it to the resource created for the smart group. **Try both**
2. Run `terraform plan` and `terraform apply` to modify the policy
3. Verify that the changes have been successful UI

##### Exercise 3 - Modifying a policies payloads

You now have a policy that is scoped to all. Let's say you want to have a maintenance payload attached to the payload to run an inventory collection after the script runs. Let's add that into the policy.

Using the link to the terraform registry above, find the maintenance payload and follow these steps:

1. Modify the `payloads` attribute and add in the maintenance payload, configure it to run an inventory update
2. Run `terraform plan` and `terraform apply` to modify the policy
3. Verify that the change have been successful in the UI

##### Exercise 4 - Drift Detection

Now that you have a policy created and modified in Jamf Pro, we are going to see what it looks like when you modify the policy in the UI and then re-apply your Terraform.

Follow these steps:

1. Browse to your Jamf Pro tenant
2. Find the policy that you have just created
3. Make a change in the policy, whether that is to the scope, the payloads or the name. Make whatever change you want
4. Now in your Terraform project, run a `terraform plan`
5. Look at the output of the command and notice the changes it is detecting
6. Now run a `terraform apply` to revert the changes back to the desired state of the terraform code
7. Verify the changes in your Jamf Pro tenant

---

## Lesson 4 - Configuration Resource Creation

Creating Configuration Profiles is a little more difficult than creating policies, because it relies on having an unsigned PLIST of the configuration to upload to the Jamf Pro tenant. This can be done in a number of ways, but the easiest way is to use the [Jamf Pro GO SDK](https://github.com/deploymenttheory/go-api-sdk-jamfpro) mentioned in the [Section Overview](/support_materials/Section%202%20-%20Management/Section%202%20-%20Management.md).

This lesson will cover how to set up the Jamf Pro GO SDK and how to create and download the Configuration Profile that will be used in the next lesson to create the Configuration Profile resource.

### Configuring the Jamf Pro GO SDK

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

### Creating the Configuration Profile in Jamf Pro

So that we can download the Configuration Profile, it has to be created in the Jamf Pro tenant. This may seem counterproductive, why is it getting created in the Jamf Pro UI and then re-created in Terraform?

This is for a few reasons. The main one being so that everything is created in code and is managed by the Terraform provider. Another reason is that in a Route to Live environment, you would create the Configuration Profile in the UI, then download it, delete the profile, and push it through your Route to Live using only the one definition in code, rather than needing to duplicate effort across all of your tenants.

So in this section, you will create a configuration profile that can be downloaded in the next part of this lesson.

Follow these steps:

1. Sign in to your Jamf Pro tenant
2. Create a Configuration Profile, this can be of anything
3. Save the profile
4. Take note of the ID of the profile which is found in the URL of the Jamf Pro Tenant

### Downloading the Configuration Profile

Now that everything is set up, you can now use the GO SDK to download the Configuration Profile.

To do this, follow these steps:

1. Ensure that everything is configured as mentioned in the steps above, namely the `configFile`, `exportDir` and `profileID`
2. The `profileID` should be configured to point to the new configuration profile that you have just created
3. Browse to the `/go-api-sdk-jamfpro-main/recipes/macos_configuration_profiles/ExportMacOSConfigurationProfileToFile/` directory in your terminal
4. Now that everything is set up, run `go run ExportMacOSConfigurationProfileToFile.go`
5. This should export your PLIST file to wherever you have set your `exportDir` variable to
6. Ensure that your PLIST file has been created
7. Now go back to your Jamf Pro tenant and delete the configuration profile in the UI

Now that you have this file, you can continue to your next lesson

---

## Lesson 5 - Computer Configurations

Following on from the previous lesson, you should now have a PLIST file of a configuration that you will use to push a new Configuration Profile to your Jamf Pro tenant.

This lesson will go over the macOS Configuration Profile resource in Terraform and discuss how to use the PLIST file to push the new profile to the Jamf Pro tenant.

### macOS Configuration Profile Resource

There are multiple ways of creating a macOS configuration profile in Terraform as mentioned previously, but the resource we are going to use today will use the PLIST that was created in the previous lesson.

The follow resource is used to create the macOS Configuration Profile:

```
variable "version_number" {
  description = "The version number to include in the name and install button text."
  type        = string
  default     = "v1.0"
}

// Minimum viable example of creating a macOS configuration profile in Jamf Pro for automatic installation using a plist source file

resource "jamfpro_macos_configuration_profile_plist" "jamfpro_macos_configuration_profile_064" {
  name                = "your-name-${var.version_number}"
  description         = "An example mobile device configuration profile."
  level               = "System"
  distribution_method = "Install Automatically" // "Make Available in Self Service", "Install Automatically"
  redeploy_on_update  = "Newly Assigned"
  payloads            = file("${path.module}/path/to/your/file.mobileconfig")
  payload_validate    = true
  user_removable      = false

  scope {
    all_computers = true
    all_jss_users = false
  }

}
```

This block also introduces a new feature that hasn't been mentioned before on these lessons. A variable block. In this instance, the variable block is used to denote a version number which can be used in the name and install button if used for Self Service.

The 2 required attributes for this resource are the `name` and `payloads` attributes. There are other optional attributes that are used for things like Self Service deployment.

You can see more about macOS Configuration Profiles on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/macos_configuration_profile_plist) webpage.

---

#### Exercises

In these exercises, you will learn how to create, update and delete a macOS configuration profile using Terraform and the PLIST created in the previous lesson.

##### Exercise 1 - Creating a macOS configuration Profile

Follow these steps:

1. Create a new directory in your Terraform project to save your PLIST file.
2. Move your PLIST file to this directory
3. Using the resource above, not including the variable block, create a new resource for your macOS Config Profile
4. Fill in all the attributes, making sure to remove the variable in the name
5. Point the `payloads` attribute to your PLIST file that you have moved into your Terraform Project
6. Run `terraform plan` and `terraform apply` to push the new config to the Jamf Pro instance
7. Verify that the change has been successful by browsing to the Jamf Pro instance and checking whether the profile was created or not

##### Exercise 2 - Modifying the configuration profile

Follow these steps:

1. Opening the PLIST file that you created, try and change some key value pairs to modify how the profile is configured
2. Save the file
3. Now modify the scope of the Config Profile, if you need help with this, try visiting the Terraform Registry webpage
4. Run a `terraform plan` and `terraform apply` to make the changes to the config profile
5. Verify the change by browsing to the config profile in the Jamf Pro instance

##### Exercise 3 - Verifying Drift Detection

Now that you have a config profile that is configured by Terraform, let's try modifying it in the UI and see the behaviour of the Terraform when we next run our `terraform apply`

Follow these steps:

1. Browse to your Jamf Pro instance
2. Find your Config Profile that you created in the previous exercise
3. Make a change to the profile, to the scope, the plist or even the distribution method
4. Save the profile
5. Come back to your Terraform Project and run a `terraform plan`
6. Notice the output of the command, it should detect a drift from the code
7. Now run a `terraform apply`
8. Verify that the `terraform apply` has reverted the changes back to the desired state defined in Terraform

##### Exercise 4 - Deleting the profile

Now that you have finished with the profile, it is time to delete it.

Follow these steps:

1. In your terraform project, delete the full resource block for the configuration profile
2. Save the file
3. Run `terraform plan`
4. Notice the output of the command, it should say that a resource is getting removed
5. Now run a `terraform apply`
6. This should have removed the configuration profile, verify this in the Jamf Pro tenant by trying to find your config profile

---

## Lesson 6 - Mobile Device Configurations

You can manage both macOS Configuration Profiles and Mobile Device Configuration Profiles using Terraform. There is very little difference between the two, other than the resource type you are using and the payload contents.

The following resource can be used to create your Mobile Device Configuration Profile:

```
resource "jamfpro_mobile_device_configuration_profile_plist" "mobile_device_configuration_profile_002" {
  name               = "Profile 002"
  description        = "Description for Profile 002"
  level              = "User Level"
  deployment_method  = "Make Available in Self Service"
  redeploy_on_update = "All"
  payloads           = file("path/to/profile_002.mobileconfig")

  scope {
    all_mobile_devices      = false
    all_jss_users           = true
    mobile_device_ids       = [4, 5, 6]
    mobile_device_group_ids = [3, 4]
    building_ids            = [2]
    department_ids          = [2]
    jss_user_ids            = [3, 4]
    jss_user_group_ids      = [2]
  }
}
```

As you can see there is very little difference between these 2 configuration resource. It follows the same requirements for attributes and will be configured in the same way.

You can see more about Mobile Device Configuration Profiles on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/mobile_device_configuration_profile_plist) webpage.

### Exercises

#### Exercise 1 - Creating a Configuration Profile for Mobile Devices

In this exercise, you will be following the same process as the previous lessons in this section.

Follow these steps:

1. Follow the previous lessons to create a basic Mobile Device Configuration Profile in Jamf Pro
2. Download the Configuration Profile using the GoLang SDK
3. Create a Mobile Device Configuration Profile using the above resource
4. Run `terraform plan` and `terraform apple`
5. Verify the change has been created in the Jamf Pro instance

#### Exercise 2 - Modifying the Configuration profile

Similar to the previous lessons, you will now modify the config plist and resource to notice the changes being made in the Jamf Tenant

Follow these steps:

1. In the plist file that was created when downloading from Jamf Pro, modify some values of the keys and save the file
2. Modify the resource as well, like the scope or name
3. Run `terraform plan` and `terraform apply` to modify the resource
4. Verify the change in the Jamf Pro tenant
