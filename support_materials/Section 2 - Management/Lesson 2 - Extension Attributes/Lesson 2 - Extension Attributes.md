# Lesson 2 - Extension Attributes

There are multiple ways to create Extension Attributes in Jamf, and in the same way, there are multiple ways to configure the Extension Attribute resource in Terraform. The following topics will be covered in this lesson:

- [Computer Extension Attributes]()
  - [Pop-up Menu Example]()
  - [Text Field Example]()
  - [Script Example]()
- [Mobile Device Extension Attribute]()

For more information on any of the resources we are going to create today, you can see the full breakdown from the schema on the [Terrafrom Registry](https://registry.terraform.io/providers/deploymenttheory/jamfpro/latest/docs/resources) webpage.

## Computer Extension Attributes

Extension Attributes have multiple functions, and they all have different ways to be configured in Terraform. There are also 2 different types of Extension Attributes, one for Computers and one for Mobile Devices. The only difference with Mobile Devices is that you can't deploy a script extension attribute.

### Pop-up Menu

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
