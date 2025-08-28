#!/bin/bash

# Base URL
BASE=http://localhost:8081
API=$BASE/v3   # if this 404s for you, set API=$BASE/api

EMAIL="Nextelevem@icloud.com"     # <- put the email you just signed up with
PASS="Tattooo82!"          # <- put your password

# 1) Sign in to get a JWT
TOKEN=$(curl -fsS -X POST "$API/auth/signin" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}" | jq -r .token)

# Fallback if jq isn't installed: 
# curl -s -X POST "$API/auth/signin" -H 'Content-Type: application/json' \
#   -d "{\"email\":\"$EMAIL\",\"password\":\"$PASS\"}"

echo "TOKEN starts with: ${TOKEN:0:20}..."

# 2) Get your project id (the one you created in the wizard)
# If you named it "Tattoo Studio", this extracts it:
PROJECT_ID=$(curl -fsS -H "Authorization: $TOKEN" "$API/projects/" \
  | jq -r '.[] | select(.id_project.name=="Tattoo Studio") | .id_project._id' | head -n1)

# If jq isn't available, you can also open the Dashboard -> Project Settings to copy the ID manually.
echo "PROJECT_ID = $PROJECT_ID"
