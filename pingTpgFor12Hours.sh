#!/bin/bash

IP=""
TPG=""
START_DATE=`date +%F`
START_HR=`date +%H`
START_MIN=`date +%M`
FILENAME="PingResults-$START_DATE-$START_HR-$START_MIN.txt"
FINISH_SECONDS=$(( `date +%s` + 43200 ))

echo "Starting a DNS testing run at" `date` >> $FILENAME

while [ `date +%s` -lt $FINISH_SECONDS ]; do
  date >> $FILENAME
  IP=`ping 10.20.22.148 -c 4`
  TPG=`ping tpg.com.au -c 4`
  echo $IP >> $FILENAME
  echo $TPG >> $FILENAME

  while [[ $IP = *"timeout"* || $TPG = *"timeout"* ]]; do
    IP=`ping 10.20.22.148 -c 10`
    TPG=`ping tpg.com.au -c 10`
    echo $IP >> $FILENAME
    echo $TPG >> $FILENAME
  done
  sleep 60
done

echo "Finished DNS testing run at" `date` >> $FILENAME
