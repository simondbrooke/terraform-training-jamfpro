# Lesson 6 - Mobile Device Configurations

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

## Exercises

### Exercise 1 - Creating a Configuration Profile for Mobile Devices

In this exercise, you will be following the same process as the previous lessons in this section.

Follow these steps:

1. Follow the previous lessons to create a basic Mobile Device Configuration Profile in Jamf Pro
2. Download the Configuration Profile using the GoLang SDK
3. Create a Mobile Device Configuration Profile using the above resource
4. Run `terraform plan` and `terraform apple`
5. Verify the change has been created in the Jamf Pro instance

### Exercise 2 - Modifying the Configuration profile

Similar to the previous lessons, you will now modify the config plist and resource to notice the changes being made in the Jamf Tenant

Follow these steps:

1. In the plist file that was created when downloading from Jamf Pro, modify some values of the keys and save the file
2. Modify the resource as well, like the scope or name
3. Run `terraform plan` and `terraform apply` to modify the resource
4. Verify the change in the Jamf Pro tenant
