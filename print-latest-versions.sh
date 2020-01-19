#!/bin/bash

github-latest-release ()
{
	if [ -z "$1" ]; then
    echo "No source repo specified"
    return
	fi
	_status_code=$(curl -s -o /dev/null -I -w "%{http_code}" https://api.github.com/repos/${1}/releases/latest)
  if [ "${_status_code}" != "404" ]; then
		curl -s https://api.github.com/repos/${1}/releases/latest | jq -r '.tag_name'
		return
	fi

	_release_count=$(curl -s https://api.github.com/repos/${1}/releases | jq length)
	if [ "$_release_count" != "0" ]; then
		curl -s https://api.github.com/repos/${1}/releases | jq -r '.[0] | .tag_name'
		return
	fi

  curl -s https://api.github.com/repos/${1}/tags | jq -r '.[0] | .name'
}

for i in $(grep VERSION_ versions-on-github); do
	_s=$(echo $i | cut -d '=' -f 1)
	_r=${_s/VERSION_/}
	_t=${_r/__/-}
	_repo=${_t/_/\/}
	_v1=$(github-latest-release $_repo)
	_v2=${_v1/_/.}
	_version=${_v2/_/.}
	echo $_s=${_version/v/}
done

