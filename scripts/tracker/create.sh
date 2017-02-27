#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/trackers"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "tracker": {
      "first_name": "'"${FIRST_NAME}"'",
      "last_name": "'"${LAST_NAME}"'",
      "grade": "'"${GRADE}"'",
      "comments": "'"${COMMENTS}"'"
    }
  }'

echo
