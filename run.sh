#!/bin/sh

main() {
  tag="$WERCKER_VERIFY_QUAY_TAG_TAG"

  if [ -z "$tag" ]; then
    tag="${WERCKER_GIT_COMMIT:-latest}"
  fi

  if [ -n "$WERCKER_VERIFY_QUAY_TAG_TOKEN" ]; then
    auth="--header 'Authorization: Bearer $WERCKER_VERIFY_QUAY_TAG_TOKEN'"
  fi

  curl_with_flags "$auth" "https://quay.io/api/v1/repository/$WERCKER_VERIFY_QUAY_TAG_REPOSITORY/tag/$tag/images" \
    || fail "$WERCKER_VERIFY_QUAY_TAG_MESSAGE"
}

curl_with_flags() { curl --fail --silent --output /dev/null "$@"; }

main
