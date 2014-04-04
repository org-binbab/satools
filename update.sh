#!/bin/sh

script_bin=$0
cd $(dirname $script_bin)

function __err() {
  echo "ERROR: $1" 1>&2
  exit 1
}

[ -e .git ] || __err "Software was not installed vi GIT. Cannot update."

git fetch
git reset --hard origin/master

echo "Update complete."
