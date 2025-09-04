# Policies

This tutorial introduces the Terraform **`jamfpro_policy`** resource (part of the `deploymenttheory/jamfpro` provider) and guides you through several hands-on lessons, so you can learn by doing.

---

## What Is `jamfpro_policy`?

The `jamfpro_policy` resource allows you to define and manage Jamf Pro Policies using Terraform, supporting Jamf Pro’s Classic and modern APIs via the community provider **deploymenttheory/jamfpro** :contentReference[oaicite:0]{index=0}.

This Terraform provider lets you codify device management resources—like policies, smart groups, scripts, configuration profiles—as infrastructure-as-code for Jamf Pro environments :contentReference[oaicite:1]{index=1}.

---

## The Policy Resource

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

### Exercises

#### Lesson 1 - Creating a basic policy

Create a basic policy that runs a script on all devices. This lesson will be similar to the one created in the health check lesson in Section 1.

Using the resource above follow these steps:

1. If not already done so, create the script and policy that was mentioned [Section 1 - Lesson 1]()
2. Use `terraform plan` and `terraform apply` to create the script and policy in your Jamf Pro instance
3. Once created, verify that the policy and script is created in your Jamf Pro instance

#### Lesson 2 - Modifying a policies scope

Now that you have created a basic policy in Jamf Pro. We are going to modify the policies scope to restrict it to a smart group that you created in a previous lesson in this section.

Using the same resource, follow these steps:

1. Modify the `scope` attribute to point the scope to the smart group created in the previous lesson. You can do this multiple ways, you can either point to the ID of the Smart Group by grabbing it from the UI, or as mentioned before, you can point it to the resource created for the smart group. **Try both**
2. Run `terraform plan` and `terraform apply` to modify the policy
3. Verify that the changes have been successful UI

#### Lesson 3 - Modifying a policies payloads

You now have a policy that is scoped to all. Let's say you want to have a maintenance payload attached to the payload to run an inventory collection after the script runs. Let's add that into the policy.

Using the link to the terraform registry above, find the maintenance payload and follow these steps:

1. Modify the `payloads` attribute and add in the maintenance payload, configure it to run an inventory update
2. Run `terraform plan` and `terraform apply` to modify the policy
3. Verify that the change have been successful in the UI

#### Lesson 4 - Drift Detection

Now that you have a policy created and modified in Jamf Pro, we are going to see what it looks like when you modify the policy in the UI and then re-apply your Terraform.

Follow these steps:

1. Browse to your Jamf Pro tenant
2. Find the policy that you have just created
3. Make a change in the policy, whether that is to the scope, the payloads or the name. Make whatever change you want
4. Now in your Terraform project, run a `terraform plan`
5. Look at the output of the command and notice the changes it is detecting
6. Now run a `terraform apply` to revert the changes back to the desired state of the terraform code
7. Verify the changes in your Jamf Pro tenant
