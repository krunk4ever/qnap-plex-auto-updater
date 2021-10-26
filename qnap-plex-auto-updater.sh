#!/bin/bash

current_dir=$(dirname "$0")
last=$( cat ${current_dir}/last)
echo "installed: ${last}"

plex_token=$(cat /share/PlexData/Plex\ Media\ Server/Preferences.xml | grep -oP 'PlexOnlineToken="\K[^"]+')
plex_url="https://plex.tv/api/downloads/5.json?channel=plexpass&X-Plex-Token=${plex_token}"
echo "Plex URL: ${plex_url}"
jq_filter=".nas.QNAP.releases[] | select(.build==\"linux-x86_64\") | .url"
latest_json=$(curl -sS "${plex_url}")
latest=$(echo "${latest_json}" | jq -r "${jq_filter}")
if [ "$last" != "$latest" ]; then
    echo "new version $latest available (prev: $last). Downloading it."
    curl "${latest}" -o ${current_dir}/plex.qpkg
    sh ${current_dir}/plex.qpkg
    rm ${current_dir}/plex.qpkg
    echo ${latest} > ${current_dir}/last
    echo "done"
else
    echo "same versions"
    echo $latest
    echo $last
fi
