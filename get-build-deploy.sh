#!/bin/bash

Version=6.5.1

#
# Get
#
DownloadUrl="https://zeroturnaround.com/software/jrebel/download/thank-you/?file=jrebel-6.5.1-nosetup.zip"
ThankfulPage=$(wget -qO- ${DownloadUrl})
Regex='<a.*href="//(.*)".*>direct link</a>'

if [[ ${ThankfulPage} =~ ${Regex} ]]
then
    ActualDownloadUrl="${BASH_REMATCH[1]}"
else
    echo "Error. Check the regex"
    exit 1
fi

if [ ! -f target/jrebel.zip ]
then
    wget ${ActualDownloadUrl} -O target/jrebel.zip
fi

#
# Build
#
cd target

unzip -o jrebel.zip

rm jrebel-${Version}.jar

zip -j jrebel-${Version}.jar jrebel/lib/*

#
# Deploy
#
mvn deploy -f ..