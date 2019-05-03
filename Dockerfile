FROM debian:9

RUN set -xe \
	\
	&& apt update -y -o Acquire::http::Pipeline-Depth="0" \
	&& DEBIAN_FRONTEND=noninteractive apt install -y -q -o Acquire::http::Pipeline-Depth="0" tzdata python2.7 python-pip texlive-full

RUN set -xe \
        \
        && echo "dash dash/sh boolean false" | debconf-set-selections \
        && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# delete all the apt list files since they're big and get stale quickly
RUN rm -rf /var/lib/apt/lists/*
# this forces "apt-get update" in dependent images, which is also good
# (see also https://bugs.launchpad.net/cloud-images/+bug/1699913)

