#!/bin/sh

main() {
  tag="$WERCKER_VERIFY_QUAY_TAG_TAG"
  curl_command="curl --fail"

  if [ -z "$tag" ]; then
    tag="${WERCKER_GIT_COMMIT:-latest}"
  fi

  if [ -z "$WERCKER_VERIFY_QUAY_TAG_MESSAGE" ]; then
    WERCKER_VERIFY_QUAY_TAG_MESSAGE="tag \"$tag\" could not be found on $WERCKER_VERIFY_QUAY_TAG_REPOSITORY"
  fi

  if [ -n "$WERCKER_VERIFY_QUAY_TAG_TOKEN" ]; then
    curl_command="$curl_command --header \"Authorization: Bearer $WERCKER_VERIFY_QUAY_TAG_TOKEN\""
  fi

  if [ "$WERCKER_VERIFY_QUAY_TAG_DEBUG" != "true" ]; then
    curl_command="$curl_command --silent --output /dev/null"
  fi

  curl_command="$curl_command https://quay.io/api/v1/repository/$WERCKER_VERIFY_QUAY_TAG_REPOSITORY/tag/$tag/images"

  if [ "$WERCKER_VERIFY_QUAY_TAG_DEBUG" = "true" ]; then
    debug "$curl_command"
  fi

  eval "$curl_command" || fail "$WERCKER_VERIFY_QUAY_TAG_MESSAGE"
}

debug() {
  printf "%b%b%b\n" "\e[38m\e[1m" "$1" "\e[m"
}

fail() {
  printf "%b%b%b\n" "\e[31m\e[1m" "failed: $1" "\e[m"
  echo "$1" > "$WERCKER_REPORT_MESSAGE_FILE"
  exit 1
}

main
