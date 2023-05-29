#!/bin/bash

# vars
timeout=200
interval=5
file="./deploy_results"
elapsed=0

while getopts ":t:i:" opt; do
  case $opt in
    t)
      timeout=$OPTARG
      ;;
    i)
      interval=$OPTARG
      ;;
    \?)
      echo "Invalid format -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
       exit 1
      ;;

  esac
done

while [ $elapsed -lt $timeout ]; do
  if [ -f "$file" ]; then
    echo "File $file created."
    break
  fi

  sleep $interval
  elapsed=$((elapsed + interval))
done

if [ $elapsed -ge $timeout ]; then
  echo "Timeout. File $file not exist."
  exit 1
fi
