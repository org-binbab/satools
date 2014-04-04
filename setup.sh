#!/bin/bash

script_bin=$0
cd $(dirname $script_bin)
BASE_PATH=$(pwd)

function __err() {
  echo "ERROR: $1" 1>&2
  exit 1
}

sysconfig_temp=/tmp/satools.sysconfig
sysconfig_dest=/etc/sysconfig/satools
SYSCONFIG=$sysconfig_dest
cp ./share/sysconfig $sysconfig_temp

OSVARIANT=$(./bin/VARIANT)
if [ "$OSVARIANT" == 'unknown' ] ; then
  __err "Unkown OS. Cannot install."
fi

tokens=(
  BASE_PATH
  SYSCONFIG
  OSVARIANT
)

for x in ${tokens[*]} ; do
  sed -i "s~%${x}%~${!x}~" $sysconfig_temp
done

cat $sysconfig_temp > $sysconfig_dest || exit 1
chmod 644 $sysconfig_dest

rm $sysconfig_temp

echo "INSTALL COMPLETE."
