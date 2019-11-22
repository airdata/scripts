#! /bin/sh

export LC_ALL=C

if [ ${#} -eq 0 ]
then
  DIR=.
else
  DIR="${1}"
fi

find "${DIR}" -type d -maxdepth 1 -mindepth 1 \
  | cut -c 3- \
  | while read I
    do
      find "${I}" | wc -l | tr -d '\n'
      echo " ${I}"
    done | sort -n
