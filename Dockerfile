FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    lsb-release \
    wget \
    curl \
    gnupg2

RUN wget https://repo.percona.com/apt/percona-release_latest.focal_all.deb \
    dpkg -i percona-release_latest.focal_all.deb

RUN apt-get update && apt-get install -y \
    percona-xtrabackup-24 \
    qpress

WORKDIR /backupdir

ENTRYPOINT ["innobackupex"]
