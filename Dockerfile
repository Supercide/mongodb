FROM ubuntu:16.10
MAINTAINER Jordan Anderson Mr@jordananderson.io

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt install -y --reinstall gnupg2 && \
    apt install -y dirmngr && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update && \
    apt-get install --force-yes mongodb-org=3.6.0 mongodb-org-server=3.6.0 mongodb-org-shell=3.6.0 mongodb-org-mongos=3.6.0 mongodb-org-tools=3.6.0 && \
    echo "mongodb-org hold" | dpkg --set-selections && \
    echo "mongodb-org-server hold" | dpkg --set-selections && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-mongos hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections

VOLUME ["/data/db"]

WORKDIR /data

ADD run.sh /run.sh
ADD set_credentials.sh /set_credentials.sh

EXPOSE 27017 28017

CMD ["/run.sh"]