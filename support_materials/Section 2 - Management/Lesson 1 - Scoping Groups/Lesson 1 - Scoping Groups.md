# Lesson 1 - Scoping Groups

This lesson will describe how to create Smart Group resources. Using similar techniques as in the previous section, you can create smart groups in your terraform project and then link to them in policies either by their ID in Jamf Pro or by using the resource ID in Terraform. Using the Terraform resource ID can make the codebase dynamic and will mean that whenever you update the Smart Group, it will automatically sync with whatever the smart group is scoped to.

In this lesson, we will cover the following topics:

- [Static Computer & Mobile Device Groups](#static-computer--mobile-groups)
- [Smart Computer & Mobile Device Groups](#smart-computer--mobile-groups)


For more information on any of the resources we are going to create today, you can see the full breakdown from the schema on the [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources) webpage.

## Static Computer & Mobile Groups

Static Computer Groups in Terraform require you to know all Computer IDs in Jamf Pro so that you can scope the specific devices to the Group. Creating Static Computer Groups can be done by using the following resource:

```
resource "jamfpro_static_computer_group" "jamfpro_static_computer_group_001" {
  name = "Example Static Computer Group"


  # Optional Block
  site_id = 1

  # Optional: Specify computers for static groups
  assigned_computer_ids = [1, 2, 3]
}
```

The only required attribute in this resource is the `name`. Although, if you actually want to scope devices to the group, you will need to have the `assigned_computer_ids` attribute configured as well.

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/static_computer_group) webpage.

Mobile Device Groups are similar to the Computer Groups, except the resource block would be:

```
resource "jamfpro_static_mobile_device_group" "jamfpro_static_mobile_device_group_001" {
  name = "Example Mobile Device Group"


  # Optional Block
  site_id = 1

  # Optional: Specify computers for static groups
  assigned_mobile_device_ids = [1, 2, 3]
}
```

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/static_mobile_device_group) webpage.

## Smart Computer & Mobile Groups

Smart Groups in Terraform work exactly the same as the way that Smart Groups work in the Jamf Pro UI. You will be required to know the criteria and operators for the criteria. To create a Smart Computer Group in Terraform, you can use the following resource:

```
resource "jamfpro_smart_computer_group" "smart_example" {
  name = "Example Smart Computer Group"

  # Optional: Specify site details
  site_id = 5

  # Optional: Define criteria for Smart groups
  criteria {
    name          = "Criterion Name #1"
    priority      = 0     # 0 is the highest priority, 1 is the next highest, etc.
    and_or        = "and" # or "or", defaults to "and" if not provided
    search_type   = "is"  # or any other supported search type
    value         = "Criterion Value"
    opening_paren = false # true or false, defaults to false if not provided
    closing_paren = false # true or false, defaults to false if not provided
  }

  criteria {
    name          = "Criterion Name #n+1 etc"
    priority      = 1
    and_or        = "and" # or "or", defaults to "and" if not provided
    search_type   = "is"  # or any other supported search type
    value         = "Criterion Value"
    opening_paren = false # true or false, defaults to false if not provided
    closing_paren = false # true or false, defaults to false if not provided
  }

}
```

The only required attribute for a Smart Computer group is the `name` attribute. All other attributes are optional, but required if you want to define a group that computers are scoped to, similar to if you were using the UI.

You can see more about Static Computer Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/smart_computer_group) webpage.

Smart Mobile Device Groups work the exact same as Smart Computer Groups, just using a different resource. This resource is resource for Smart Mobile Device Groups:

```
resource "jamfpro_smart_mobile_device_group" "smart_example" {
  name = "Example Smart Mobile Device Group"

  # Optional: Specify site details
  site_id = 5

  # Optional: Define criteria for Smart groups
  criteria {
    name          = "Criterion Name #1"
    priority      = 0     # 0 is the highest priority, 1 is the next highest, etc.
    and_or        = "and" # or "or", defaults to "and" if not provided
    search_type   = "is"  # or any other supported search type
    value         = "Criterion Value"
    opening_paren = false # true or false, defaults to false if not provided
    closing_paren = false # true or false, defaults to false if not provided
  }

  criteria {
    name          = "Criterion Name #n+1 etc"
    priority      = 1
    and_or        = "and" # or "or", defaults to "and" if not provided
    search_type   = "is"  # or any other supported search type
    value         = "Criterion Value"
    opening_paren = false # true or false, defaults to false if not provided
    closing_paren = false # true or false, defaults to false if not provided
  }

}
```

You can see more about Static Mobile Device Groups on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/smart_mobile_device_group) webpage.

### Scoping Groups - Exercise 1 - Creating a Static Computer Group

In this exercise you will create a Static Computer Group using the resource mentioned above. This exercise requires that you have device records in your Jamf Pro instance so that you can use the Device ID's.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_static_computer_groups.tf`
2. Add in the resource mentioned in the Static Computer Groups section above and configure the Static Computer Group attributes by giving it a name and adding in some valid computer IDs from you Jamf Pro instance
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

### Scoping Groups - Exercise 2 - Creating a Static Mobile Device Group

This exercise will be similar to the previous, but instead of creating a Static Computer Group, you will create a Static Mobile Device Group.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_static_mobile_device_groups.tf`
2. Follow the same steps as in Exercise 1, but using the Mobile Device Static Group resource.
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

### Scoping Groups - Exercise 3 - Creating a Smart Computer Group

In this exercise you will create a Smart Computer Group using the resource mentioned above. In this exercise, you can create a Smart Group with whatever criteria that you want.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_smart_computer_groups.tf`
2. Add in the resource mentioned in the Smart Computer Groups section above and configure the Static Computer Group attributes by giving it a name and adding in a search criteria
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory

### Scoping Groups - Exercise 4 - Creating a Smart Mobile Device Group

This exercise will be similar to the previous, but instead of creating a Smart Computer Group, you will create a Smart Mobile Device Group.

Follow these steps:

1. Create a new file in your project in the `/workload/terraform/jamfpro/` directory and name it `jamfpro_smart_mobile_device_groups.tf`
2. Follow the same steps in Exercise 3, but using the Mobile Device Smart Group resource.
3. Save the file
4. Run your terraform and create the site by running the `terraform apply` command in the terminal in the `/workload/terraform/jamfpro` directory
