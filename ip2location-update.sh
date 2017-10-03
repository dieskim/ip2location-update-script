#!/bin/sh

## HOW TO
## 1. Download download.pl - 'https://www.ip2location.com/free/downloader'
## 2. Download this SCRIPT
## 3. Place them in same folder as your destination where you want you IP2LOCATION bins
## 4. SET VARS BELOW
## 5. RUN USING 'sh -x ip2location-update.sh 2>&1 | tee ip2location-update-log.txt'
## 6. Create Cronjob to run on one of the first days of month

## SET ADMIN EMAIL
ADMINEMAIL=yourname@yourhost.com
EMAILSUBJECT=YOURHOST-IP2LOCATION-UPDATE

## MAIL COMMAND
MAILCOMMAND=mail

## LOGFILE
LOGFILE=ip2location-update-log.txt

## SET IP2USER AND IP2PASS
IP2USER=yourIP2LOCATIONuser
IP2PASS=yourIP2LOCATIONpassword

## SET DATABASES - database you want to download + ipv6
DATABASE=DB11LITEBIN
DATABASEIPV6=DB11LITEBINIPV6

## SET ZIP FILE - zip name of the database
ZIPFILE=IP2LOCATION-LITE-DB11.BIN.ZIP
ZIPFILEIPV6=IP2LOCATION-LITE-DB11-IPV6.BIN.ZIP

##### DO NOT EDIT BELOW ###

## CD
cd "${0%/*}"

## DOWNLOAD DATABASE
./download.pl -package $DATABASE -login $IP2USER -password $IP2PASS

## UNZIP ZIPFILE
unzip -o $ZIPFILE

## REMOVE ZIPFILE
rm $ZIPFILE

## DOWNLOAD DATABASEIPV6
./download.pl -package $DATABASEIPV6 -login $IP2USER -password $IP2PASS

## UNZIP ZIPFILEIPV6
unzip -o $ZIPFILEIPV6

## REMOVE ZIPFILEIPV6
rm $ZIPFILEIPV6

## SEND SUCCESS MAIL
$MAILCOMMAND -s $EMAILSUBJECT $ADMINEMAIL < $LOGFILE

## REMOVE LOGFILE
rm $LOGFILE
