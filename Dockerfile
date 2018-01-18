# This is a meta jenkins slave to build other jenkins slave docker images
FROM debian:stable

# Upgrade packages on image, install openssh-server and git and docker and cleanup repo
RUN apt-get update &&  apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     openssh-server \
     git \
     openjdk-8-jdk \
     && curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add - \
     && apt-key fingerprint 0EBFCD88 \
     && add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) edge" \
     && apt-get update && apt-get install -y docker-ce=17.05.0~ce-0~debian-jessie &&\
     apt-get -q autoremove &&\
     apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd -D"]
