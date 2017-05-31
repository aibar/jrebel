#!/bin/bash

Version=7.0.9

#
# Get
#
DownloadUrl="https://zeroturnaround.com/software/jrebel/download/thank-you/?file=jrebel-${Version}-nosetup.zip"
ThankfulPage=$(wget -qO- ${DownloadUrl})
Regex='<a.*href="//(.*)".*>direct link</a>'

if [[ ${ThankfulPage} =~ ${Regex} ]]
then
    ActualDownloadUrl="${BASH_REMATCH[1]}"
else
    echo "Error. Check the regex"
    exit 1
fi

wget ${ActualDownloadUrl} -O target/jrebel.zip

#
# Package libs as ZIP
#
cd target

unzip -o jrebel.zip

rm jrebel-${Version}.jar

mv jrebel/jrebel.jar jrebel/lib
zip -j jrebel-${Version}.jar jrebel/lib/*