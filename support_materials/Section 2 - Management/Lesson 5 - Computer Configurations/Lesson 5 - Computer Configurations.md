# Computer Configurations

Following on from the previous lesson, you should now have a PLIST file of a configuration that you will use to push a new Configuration Profile to your Jamf Pro tenant.

This lesson will go over the macOS Configuration Profile resource in Terraform and discuss how to use the PLIST file to push the new profile to the Jamf Pro tenant.

## macOS Configuration Profile Resource

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

### Exercises

In these exercises, you will learn how to create, update and delete a macOS configuration profile using Terraform and the PLIST created in the previous lesson.

#### Exercise 1 - Creating a macOS configuration Profile

Follow these steps:

1. Create a new directory in your Terraform project to save your PLIST file.
2. Move your PLIST file to this directory
3. Using the resource above, not including the variable block, create a new resource for your macOS Config Profile
4. Fill in all the attributes, making sure to remove the variable in the name
5. Point the `payloads` attribute to your PLIST file that you have moved into your Terraform Project
6. Run `terraform plan` and `terraform apply` to push the new config to the Jamf Pro instance
7. Verify that the change has been successful by browsing to the Jamf Pro instance and checking whether the profile was created or not

#### Exercise 2 - Modifying the configuration profile

Follow these steps:

1. Opening the PLIST file that you created, try and change some key value pairs to modify how the profile is configured
2. Save the file
3. Now modify the scope of the Config Profile, if you need help with this, try visiting the Terraform Registry webpage
4. Run a `terraform plan` and `terraform apply` to make the changes to the config profile
5. Verify the change by browsing to the config profile in the Jamf Pro instance

#### Exercise 3 - Verifying Drift Detection

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

#### Exercise 4 - Deleting the profile

Now that you have finished with the profile, it is time to delete it.

Follow these steps:

1. In your terraform project, delete the full resource block for the configuration profile
2. Save the file
3. Run `terraform plan`
4. Notice the output of the command, it should say that a resource is getting removed
5. Now run a `terraform apply`
6. This should have removed the configuration profile, verify this in the Jamf Pro tenant by trying to find your config profile
