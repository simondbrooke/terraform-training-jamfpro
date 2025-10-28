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


  resource "jamfpro_smart_computer_group" "NotCheckedIn" {
        name     = "Devices Not Checked In (30+ Days)"
        site_id  = -1

        criteria {
          and_or        = "and"
          closing_paren = false
          name          = "Last Check-in"
          opening_paren = false
          priority      = 0
          search_type   = "more than x days ago"
          value         = "30"
        }
    }

import {
  id = 224
  to = jamfpro_smart_computer_group.NotCheckedIn
}