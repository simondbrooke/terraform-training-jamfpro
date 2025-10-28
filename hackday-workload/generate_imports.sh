#!/bin/bash

# ==============================================================================
# SCRIPT:   Generate Jamf Pro Category Import Script (OAuth)
# PURPOSE:  Generates 'terraform import' commands for all categories
#           using Client ID and Client Secret authentication.
#
# REQUIRES: curl, jq, sed
# ==============================================================================

# 1. --- Get User Credentials ---
read -p "Enter your Jamf Pro URL (e.g., https://your.jamf.pro): " jamfURL
read -p "Enter your Jamf Pro Client ID: " jamfClientID
read -sp "Enter your Jamf Pro Client Secret: " jamfClientSecret
echo # Add a newline after the hidden password prompt

# Clean up URL (remove trailing slash if it exists)
jamfURL="${jamfURL%/}"

# 2. --- Authenticate and Get Bearer Token (OAuth) ---
echo
echo "🔒 Authenticating with $jamfURL using Client ID..."

# Use --data-urlencode to safely handle special characters in the secret
tokenResponse=$(curl -s -X POST "${jamfURL}/api/oauth/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-urlencode "grant_type=client_credentials" \
     --data-urlencode "client_id=${jamfClientID}" \
     --data-urlencode "client_secret=${jamfClientSecret}")

# The OAuth endpoint returns 'access_token', not 'token'
token=$(echo "$tokenResponse" | jq -r .access_token)

# Check if token was successfully retrieved
if [ "$token" == "null" ] || [ -z "$token" ]; then
    echo "❌ Error: Could not retrieve authentication token."
    echo "Please check your URL, Client ID, and Client Secret."
    echo "Make sure the API Client has permissions to 'Read Categories'."
    echo "Server Response: $tokenResponse"
    exit 1
fi

echo "✅ Successfully authenticated."

# 3. --- Fetch Category Data ---
echo "🚚 Fetching categories..."
# The token is used in the Authorization header just like before
apiData=$(curl -s -H "Authorization: Bearer ${token}" -H "Accept: application/json" "${jamfURL}/JSSResource/categories")

if [ -z "$apiData" ]; then
    echo "❌ Error: No data received from API."
    exit 1
fi

# 4. --- Generate Terraform Import Commands ---
echo
echo "--- Copy the commands below to import your categories ---"
echo "# Ensure you have matching 'resource \"jamf_category\" \"...\" {}' blocks in your .tf files"
echo

# Process the JSON, pipe to a loop to read ID and Name
echo "$apiData" | jq -r '.categories[] | "\(.id)\t\(.name)"' | while IFS=$'\t' read -r id name; do
    
    # Handle the "No Category" case (ID -1), which is special
    if [ "$id" == "-1" ]; then
        echo "# Skipping built-in 'No Category' (ID: -1)"
        continue
    fi

    # Sanitize the name for use as a Terraform resource address:
    # 1. Convert to lowercase
    # 2. Replace spaces and hyphens with underscores
    # 3. Remove all other non-alphanumeric characters (except underscore)
    resource_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | sed -e 's/[ -]/_/g' -e 's/[^a-z0-9_]//g')

    # Output the import command
    # Using single quotes to prevent shell expansion issues
    echo "terraform import 'jamf_category.${resource_name}' ${id}"

done

echo
echo "--- End of import commands ---"
echo "✅ Done."

exit 0