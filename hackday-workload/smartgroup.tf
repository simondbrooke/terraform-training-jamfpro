  resource "jamfpro_smart_computer_group" "FileVault" {
        name     = "Devices Missing FileVault"
        site_id  = -1

        criteria {
          and_or        = "and"
          closing_paren = false
          name          = "FileVault 2 Enabled"
          opening_paren = false
          priority      = 0
          search_type   = "is"
          value         = "No"
        }
    }

import {
  id = 226
  to = jamfpro_smart_computer_group.FileVault
}