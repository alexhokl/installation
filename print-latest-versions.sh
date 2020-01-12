#!/bin/bash

github-latest-release ()
{
    if [ -z "$1" ]; then
        echo "No source repo specified";
        return;
    fi;
    _status_code=$(curl -s -o /dev/null -I -w "%{http_code}" https://api.github.com/repos/${1}/releases/latest);
    if [ "${_status_code}" = "404" ]; then
        curl -s https://api.github.com/repos/${1}/releases | jq -r '.[0] | .tag_name';
    else
        curl -s https://api.github.com/repos/${1}/releases/latest | jq -r '.tag_name';
    fi
}

for i in $(grep VERSION_ versions-on-github); do
	_s=$(echo $i | cut -d '=' -f 1)
	_r=${_s/VERSION_/}
	_t=${_r/__/-}
	_repo=${_t/_/\/}
	_v=$(github-latest-release $_repo)
	echo $_s=${_v/v/}
done

