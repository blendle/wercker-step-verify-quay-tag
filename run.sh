#!/bin/sh
#shellcheck disable=2086,2089,SC2090

main() {
  args="--fail --silent --output /dev/null"
  tag="$WERCKER_VERIFY_QUAY_TAG_TAG"

  if [ -z "$tag" ]; then
    tag="${WERCKER_GIT_COMMIT:-latest}"
  fi

  if [ -z "$WERCKER_VERIFY_QUAY_TAG_MESSAGE" ]; then
    WERCKER_VERIFY_QUAY_TAG_MESSAGE="tag \"$tag\" could not be found on $WERCKER_VERIFY_QUAY_TAG_REPOSITORY"
  fi

  if [ -n "$WERCKER_VERIFY_QUAY_TAG_TOKEN" ]; then
    auth="--header 'Authorization: Bearer $WERCKER_VERIFY_QUAY_TAG_TOKEN'"
  fi

  curl $args $auth "https://quay.io/api/v1/repository/$WERCKER_VERIFY_QUAY_TAG_REPOSITORY/tag/$tag/images" \
    || fail "$WERCKER_VERIFY_QUAY_TAG_MESSAGE"
}

fail() {
  printf "%b%b%b\n" "\e[1;31m" "failed: $1" "\e[m"
  echo "$1" > "$WERCKER_REPORT_MESSAGE_FILE"
  exit 1
}

main
