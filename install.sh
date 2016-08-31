#!/bin/bash

set -e
rm -rf /opt/webex-firefox
mkdir /opt/webex-firefox

FIREFOX_TAR_FILE=`ls /root/resources/firefox*`
JRE_FILE=`ls /root/resources/jre*`
echo "FIREFOX: $FIREFOX_TAR_FILE, JRE: $JRE_FILE"

cp $FIREFOX_TAR_FILE /opt/webex-firefox/
cp $JRE_FILE /opt/webex-firefox/

#install 32 libraries with dependencies
#sudo apt-get install libgtk2.0-0:i386 libpangoxft-1.0-0:i386 libpangox-1.0-0:i386 libxmu6:i386 libxtst6:i386 libdbus-glib-1-2:i386 -y
#sudo apt-get install lib32stdc++6 libasound2 -y

cd /opt/webex-firefox

#unpack
tar xfj $FIREFOX_TAR_FILE
tar xfz $JRE_FILE
rm firefox*.tar.bz2
rm jre*.tar.gz
mv jre* java

#create symlink for java plugin
cd firefox/browser
mkdir plugins
cd plugins
ln -s ../../../java/lib/i386/libnpjp2.so .
cd ../../../

#### RUN with openjdk
#sudo apt-get install openjdk-7-jdk:i386 icedtea-7-plugin:i386
#ln -s /usr/lib/jvm/java-7-openjdk-i386/jre/lib/i386/IcedTeaPlugin.so libnpjp2.so
#echo "export PATH=\"$(pwd)/java/bin:$PATH\"" >> startfirefox


#create a starter script, as we need java command from our setup
echo "#!/bin/sh" > startfirefox
echo "export PATH=\"$(pwd)/java/bin:$PATH\"" >> startfirefox
echo "export PULSE_SERVER=/tmp/webexpulsesocket" >> startfirefox
#echo "$(pwd)/firefox/firefox -P webex -new-instance" >> startfirefox
echo "$(pwd)/firefox/firefox" >> startfirefox
chmod +x startfirefox
mv startfirefox /usr/local/bin/startfirefox


echo "Run /opt/webex-firefox/startfirefox"


