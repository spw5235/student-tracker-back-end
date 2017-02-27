#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/trackers/${ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Authorization: Token token=${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "tracker": {
      "first_name": "'"${FIRST_NAME}"'",
      "last_name": "'"${LAST_NAME}"'",
      "grade": "'"${GRADE}"'",
      "comments": "'"${COMMENTS}"'"
    }
  }'

echo

# ID=2 FIRST_NAME="Jeff" LAST_NAME="W" BORN_ON="2016-02-01" SCHOOL="QUINCY" TEACHER="G" GRADE="4"
