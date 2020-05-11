FROM ubuntu:19.04

COPY ./files/ /tmp/files

RUN rm /etc/apt/sources.list && \
    touch /etc/apt/sources.list && \
    echo 'deb http://old-releases.ubuntu.com/ubuntu/ disco main restricted' >> /etc/apt/sources.list && \
    echo 'deb http://old-releases.ubuntu.com/ubuntu/ disco-updates main restricted' >> /etc/apt/sources.list && \
    echo 'deb http://old-releases.ubuntu.com/ubuntu/ disco universe' >> /etc/apt/sources.list && \
    echo 'deb http://old-releases.ubuntu.com/ubuntu/ disco-updates universe' >> /etc/apt/sources.list && \
    echo 'deb http://old-releases.ubuntu.com/ubuntu/ disco-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1 openssh-server libstdc++6 lib32stdc++6 && \
    echo 'ctf - nproc 1500' >>/etc/security/limits.conf && \
    useradd -U -m ctf && \
    echo 'ctf:guest' | chpasswd  && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    mkdir /var/run/sshd && \
    mv /tmp/files/pwn /home/ctf/pwn && \
    mv /tmp/files/start.sh / && \
    mv /tmp/files/flag.sh / && \
    rm -rf /tmp/* /var/tmp/* && \
    sed -i 's/#Port 22/Port 9999/g' /etc/ssh/sshd_config

WORKDIR /home/ctf

CMD /start.sh

EXPOSE 9999
