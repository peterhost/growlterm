#!/bin/bash
while getopts "abc:def:ghi" flag
do
  echo "$flag" $OPTIND $OPTARG
done
echo "Resetting"
OPTIND=1
while getopts "abc:def:ghi" flag
do
  echo "$flag" $OPTIND $OPTARG
done
