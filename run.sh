#!/bin/sh

main() {
  local args

  args="--fail --silent --output /dev/null"

  if [ -n "$WERCKER_VERIFY_QUAY_TAG_TOKEN" ]; then
    args="$args --header 'Authorization: Bearer $WERCKER_VERIFY_QUAY_TAG_TOKEN'"
  fi

  curl $args https://quay.io/api/v1/repository/$WERCKER_VERIFY_QUAY_TAG_REPOSITORY/tag/$WERCKER_VERIFY_QUAY_TAG_TAG/images \
    || fail $WERCKER_VERIFY_QUAY_TAG_MESSAGE
}

main
