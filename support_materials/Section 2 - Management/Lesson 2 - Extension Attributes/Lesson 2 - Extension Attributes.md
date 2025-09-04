# Lesson 2 - Extension Attributes

There are multiple ways to create Extension Attributes in Jamf, and in the same way, there are multiple ways to configure the Extension Attribute resource in Terraform. The following topics will be covered in this lesson:

- [Computer Extension Attributes](#computer-extension-attributes)
  - [Pop-up Menu Example](#pop-up-menu-example)
  - [Text Field Example](#text-field-example)
  - [Script Example](#script-example)
- [Mobile Device Extension Attribute](#mobile-device-extension-attributes)

For more information on any of the resources we are going to create today, you can see the full breakdown from the schema on the [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources) webpage.

## Computer Extension Attributes

Extension Attributes have multiple functions, and they all have different ways to be configured in Terraform. There are also 2 different types of Extension Attributes, one for Computers and one for Mobile Devices. The only difference with Mobile Devices is that you can't deploy a script extension attribute.

### Pop-up Menu Example

Configuring an extension attribute with a pop-up menu can be configured using the following resource:

```
# Pop-up Menu Example
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

### Text Field Example

To configure an extension attribute with a text field you can use the following resource:

```
# Text Field Example
resource "jamfpro_computer_extension_attribute" "computer_extension_attribute_text_field_1" {
  name                   = "tf-example-cexa-text-field-example"
  enabled                = true
  description            = "An attribute collected from a text field."
  input_type             = "TEXT"
  inventory_display_type = "HARDWARE"
  data_type              = "STRING"
}
```

### Script Example

Configuring the script extension attribute has a little more involved, which needs to include a script which will be deployed to the devices. It can be configured using the following resource:

```
# Script Example
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

## Mobile Device Extension Attributes

Mobile Device Extension Attributes are configured exactly the same as Computer Extension Attributes, just with a different resource. As mentioned previously, the main difference is that there is no Script input type on the Mobile Device Extension Attributes.

The following resource examples are how you would configure the Mobile Device Extension Attributes:

```
# Pop-up menu Example
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
# Text Field Example
resource "jamfpro_mobile_device_extension_attribute" "text_field_example" {
  name                   = "User Department"
  description            = "The department to which the device user belongs"
  data_type              = "STRING"
  inventory_display_type = "GENERAL"
  input_type             = "TEXT"
}
```

You can see more about Mobile Device Extension Attributes on this [Terraform Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources/mobile_device_extension_attribute) webpage.

### Entension Attributes - Exercises

#### Exercise 1: Basic Attribute

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

#### Exercise 2: Drop-Down Options

Define a **Region** attribute that lets users select a region:

- Input type: `pop-up menu`
- Options: `EMEA`, `APAC`, `Americas`
- Visible in the `GENERAL` inventory

**Tasks:**

1. Configure the resource in Terraform.
2. Apply it, then log in to Jamf Pro and confirm the drop-down appears.

---

#### Exercise 3: Updating an Attribute

Start with an attribute called **Warranty Expiry**:

- Type: `DATE`
- Visible in the `GENERAL` inventory

**Tasks:**

1. Create the attribute and apply it.
2. Update the same attribute to make it visible in `USER_AND_LOCATION` inventory.
3. Add a description: `"Date the warranty expires"`.

---

#### Exercise 4: Multiple Attributes

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

#### Exercise 5: Drift Detection

1. Create an attribute called **Asset Tag**:
   - Type: `string`
   - Visible in `GENERAL` inventory
2. After applying, manually change the attribute in the Jamf Pro console (e.g., change the name or disable inventory visibility).
3. Run `terraform plan` to see how Terraform detects drift.
4. Use `terraform apply` to bring the resource back to the desired state.
