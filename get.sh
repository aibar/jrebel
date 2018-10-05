#!/bin/bash

Version=2018.2.0

#
# Get
#
download () {
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
    wget ${ActualDownloadUrl} -O jrebel.zip
}

if [ ! -f jrebel.zip ]; then
    download
fi

#
# Package libs as ZIP
#
rm -rf target

mkdir target

cd target

unzip -o ../jrebel.zip

mv jrebel/jrebel.jar jrebel/lib

zip -j jrebel-${Version}.jar jrebel/lib/*

unzip -l jrebel-${Version}.jar

mkdir maven-archiver

cat >> maven-archiver/pom.properties << eof
#Created by Apache Maven 3.5.4
version=${Version}
groupId=jrebel
artifactId=jrebel