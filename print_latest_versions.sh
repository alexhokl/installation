#!/bin/bash

set -eu

if ! command -v xh &>/dev/null; then
  echo "xh is not installed or not in PATH" >&2
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo "jq is not installed or not in PATH" >&2
  exit 1
fi

_XH_AUTH=()
if [ -n "$GITHUB_TOKEN" ]; then
  _XH_AUTH=(-A bearer -a "$GITHUB_TOKEN")
fi

github_latest_release ()
{
  if [ -z "$1" ]; then
    echo "No source repo specified"
    return
  fi
  _status_code=$(xh --ignore-stdin --no-check-status -h HEAD https://api.github.com/repos/${1}/releases/latest 2>/dev/null | awk 'NR==1{print $2}')
  if [ "${_status_code}" == "200" ]; then
    xh --ignore-stdin -b GET https://api.github.com/repos/${1}/releases/latest | jq -r '.tag_name'
    return
  elif [ "${_status_code}" != "404" ]; then
    echo "Unexpected status ${_status_code} for ${1}" >&2
    return 1
  fi

  _releases=$(xh --ignore-stdin -b GET https://api.github.com/repos/${1}/releases)
  if [ "$(echo "$_releases" | jq length)" != "0" ]; then
    echo "$_releases" | jq -r '.[0] | .tag_name'
    return
  fi

  xh --ignore-stdin -b  GET https://api.github.com/repos/${1}/tags | jq -r '.[0] | .name'
}

TEMP_FILE=$(mktemp)
/bin/cp versions_on_github.json "$TEMP_FILE"

for _repo in $(jq -r 'keys[]' versions_on_github.json); do
	_v1=$(github_latest_release "$_repo")
	if [ $? -ne 0 ] || [ -z "$_v1" ] || [ "$_v1" == "null" ]; then
		echo "Skipping $_repo: could not determine version" >&2
		continue
	fi
	_version=${_v1/v/}
	TEMP_FILE_NEW=$(mktemp)
	jq --arg repo "$_repo" --arg ver "$_version" '.[$repo] = $ver' "$TEMP_FILE" > "$TEMP_FILE_NEW"
	/bin/mv -f "$TEMP_FILE_NEW" "$TEMP_FILE"
done

/bin/cp -f "$TEMP_FILE" versions_on_github.json
