# Overview

An Ubuntu 14.04 based docker image for running Cisco WebEx on 64-bit Linux systems.

# Preparations

In order to run Cisco WebEx you need to download the 32-bit version of ***Java Runtime*** and ***Firefox browser***.
This image has been tested with *Oracle JRE build 8u91* (jre-8u91-linux-i586.tar.gz) and *Firefox 45* (firefox-45.0.tar.bz2) that will be used in this instructions.

Use on of the following links for downloading Oracle Java - download the **i586** version:
- Main download page: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
- Latest JRE 8: <http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html>
- Archive: <http://www.oracle.com/technetwork/java/archive-139210.html>

Links for Firefox - download the **i686** version:
- Main download page: <https://www.mozilla.org/en-US/firefox/all/>
- All releases: <https://ftp.mozilla.org/pub/firefox/releases>
- Firefox 45.0: <https://ftp.mozilla.org/pub/firefox/releases/45.0/linux-i686/en-US/firefox-45.0.tar.bz2>


# Host Prerequisites

On the host (your machine) you need to install *PulseAudio Preferences*:

```bash
sudo apt-get install paprefs
```

Next, you need to enable **network access to local sound devices**: Launch PulseAudio Preferences, go to "Network Server" tab and check the **Enable network access to local sound devices** checkbox.

After the above steps are done, restart your computer.


# Installation

First, clone this repository.

Next, place the *jre-8u91-linux-i586.tar.gz* and *firefox-45.0.tar.bz2* in the *resources* directory.

From the root directory (where Dockerfile is located) run the following command:

```bash
docker build -t webexondocker1404 .
```

This will create a docker image named **webexondocker1404**.


# Running Cisco WebEx

First, enable accessing the X Server from any host:
```bashwe
xhost +
> access control disabled, clients can connect from any host
```

Then, start the docker container:

```bash
docker run -d -p 2222:22 -v /run/user/$UID/pulse/native:/tmp/webexpulsesocket --name WebexOnDocker webexondocker1404
```

Now you can run Firefox and start using Cisco WebEx:

```bash
#root password is root
ssh root@localhost -p 2222 -X startfirefox
```

Remember to stop/remove the docker container once you finish:

```bash
docker rm -f WebexOnDocker
```

# Enjoy!
