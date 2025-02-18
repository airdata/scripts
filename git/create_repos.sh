#!/bin/bash

# Replace these variables with your GitHub username and personal access token
USERNAME="airdata"
TOKEN="" #NEED VAR

# List of repository names
repos=("expfeed" "airdata2" "airdata3")

# GitHub API base URL
API_URL="https://api.github.com/user/repos"
API_URL_USERNAME="https://api.github.com/repos/$USERNAME"

create () {
# Loop through each repository name
for repo in "${repos[@]}"; do
    # Create repository using GitHub API
    response=$(curl -s -H "Authorization: token $TOKEN" -d '{"name":"'"$repo"'"}' $API_URL)

    # Check if the repository was created successfully
    if [[ "$response" == *"\"name\":\"$repo\""* ]]; then
        echo "Repository '$repo' created successfully."
    else
        echo "Failed to create repository '$repo'."
        echo "Response from GitHub API: $response"
    fi
done
}

delete () {
# Loop through each repository name
for repo in "${repos[@]}"; do
    # Delete repository using GitHub API
    response=$(curl -s -X DELETE -H "Authorization: token $TOKEN" "$API_URL_USERNAME/$repo")

    # Check if the repository was deleted successfully
    if [[ "$response" == "" ]]; then
        echo "Repository '$repo' deleted successfully."
    else
        echo "Failed to delete repository '$repo'."
        echo "Response from GitHub API: $response"
    fi
done
}

delete